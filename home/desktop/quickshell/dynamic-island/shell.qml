import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Wayland
import "./Common"
import "./Content"

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: islandWindow
        required property var modelData
        screen: modelData

        anchors {
            bottom: true
            left: true
            right: true
        }
        implicitHeight: 80
        margins { bottom: 0 }

        color: "transparent"
        exclusiveZone: -1
        WlrLayershell.namespace: "qs-dynamic-island"
        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
        WlrLayershell.focusable: root.isLyricsMode || root.showTranslate

        Item {
            id: hitBoxRegion
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.isCollapsedMode ? 400 : root.width
            height: root.isCollapsedMode ? 32 : root.height
        }
        mask: Region { item: hitBoxRegion }

        ClippingRectangle {
            id: root
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            bottomLeftRadius: 0
            bottomRightRadius: 0
            color: Appearance.colors.colLayer0

            property real animRadius: targetR
            radius: animRadius

            property bool showLyrics: false
            property bool showTranslate: false
            property bool isLyricsMode: showLyrics && !showTranslate
            property bool isCollapsedMode: !showLyrics && !showTranslate
            property bool isCollapsedHovered: isCollapsedMode && islandMouseArea.containsMouse

            property bool autoDismissed: false
            property bool lyricsPeek: false
            property string lastTrackId: ""
            property var currentPlayer: null
            readonly property var allowedPlayers: ["splayer"]

            Timer {
                id: lyricsHideDebounce
                interval: 150; repeat: false
                onTriggered: root.showLyrics = false
            }

            property int targetR: isLyricsMode ? 24 : (showTranslate ? 24 : (isCollapsedHovered ? 18 : 4))
            property int targetW: isLyricsMode ? lyricsWidget.implicitWidth
                : (showTranslate ? translatorWidget.implicitWidth : 230)
            property int targetH: isLyricsMode ? lyricsWidget.implicitHeight
                : (showTranslate ? translatorWidget.implicitHeight : (isCollapsedHovered ? 32 : 4))

            property real wDamping: DynamicIslandMotion.initialDamping
            property real hDamping: DynamicIslandMotion.initialDamping
            property real rDamping: DynamicIslandMotion.initialDamping

            width: targetW
            height: targetH

            onTargetWChanged: { wDamping = (targetW > width) ? DynamicIslandMotion.expandingDamping : DynamicIslandMotion.shrinkingDamping }
            onTargetHChanged: { hDamping = (targetH > height) ? DynamicIslandMotion.expandingDamping : DynamicIslandMotion.shrinkingDamping }
            onTargetRChanged: { rDamping = (targetR > animRadius) ? DynamicIslandMotion.expandingDamping : DynamicIslandMotion.shrinkingDamping }

            Behavior on width { SpringAnimation { spring: DynamicIslandMotion.spring; mass: DynamicIslandMotion.mass; damping: root.wDamping; epsilon: DynamicIslandMotion.epsilon } }
            Behavior on height { SpringAnimation { spring: DynamicIslandMotion.spring; mass: DynamicIslandMotion.mass; damping: root.hDamping; epsilon: DynamicIslandMotion.epsilon } }
            Behavior on animRadius { SpringAnimation { spring: DynamicIslandMotion.spring; mass: DynamicIslandMotion.mass; damping: root.rDamping; epsilon: DynamicIslandMotion.epsilon } }

            focus: isLyricsMode || showTranslate
            Keys.onEscapePressed: (event) => {
                root.showLyrics = false
                root.showTranslate = false
                lyricsHideDebounce.stop()
                root.autoDismissed = true
                translatorWidget.stop()
                event.accepted = true
            }

            function isPlayerAllowed(player) {
                if (!player) return false
                var id = (player.identity + player.dbusName).toLowerCase()
                for (var i = 0; i < root.allowedPlayers.length; i++) {
                    if (id.indexOf(root.allowedPlayers[i].toLowerCase()) !== -1) return true
                }
                return false
            }

            property var _prevPlayer: null
            onCurrentPlayerChanged: {
                if (_prevPlayer) {
                    _prevPlayer.isPlayingChanged.disconnect(onPlayingChanged)
                    _prevPlayer.trackChanged.disconnect(onTrackChanged)
                }
                _prevPlayer = currentPlayer
                if (currentPlayer) {
                    currentPlayer.isPlayingChanged.connect(onPlayingChanged)
                    currentPlayer.trackChanged.connect(onTrackChanged)
                }
            }

            function showLyricsIfAllowed() {
                if (!root.autoDismissed) {
                    lyricsHideDebounce.stop()
                    root.showLyrics = true
                }
            }

            function onPlayingChanged() {
                if (!root.currentPlayer) return
                if (root.currentPlayer.isPlaying) {
                    root.showLyricsIfAllowed()
                } else {
                    lyricsHideDebounce.restart()
                }
            }

            function onTrackChanged() {
                if (!root.currentPlayer || !root.currentPlayer.isPlaying) return
                var trackId = root.currentPlayer.dbusName + root.currentPlayer.trackTitle
                if (trackId !== root.lastTrackId) {
                    root.lastTrackId = trackId
                    root.autoDismissed = false
                }
                root.showLyricsIfAllowed()
            }

            function refreshPlayers() {
                var players = Mpris.players.values
                if (!players || players.length === 0) {
                    root.currentPlayer = null
                    lyricsHideDebounce.restart()
                    return
                }
                var found = null
                for (var i = 0; i < players.length; i++) {
                    if (players[i].isPlaying && root.isPlayerAllowed(players[i])) { found = players[i]; break }
                }
                if (found) {
                    if (root.currentPlayer !== found) {
                        root.currentPlayer = found
                        root.autoDismissed = false
                        root.showLyricsIfAllowed()
                    } else {
                        root.onTrackChanged()
                    }
                } else {
                    lyricsHideDebounce.restart()
                    var valid = false
                    for (var j = 0; j < players.length; j++) {
                        if (players[j] === root.currentPlayer) { valid = true; break }
                    }
                    if (!valid) root.currentPlayer = null
                }
            }

            Timer {
                id: playerPollTimer
                interval: root.currentPlayer ? 15000 : 2000
                repeat: true; triggeredOnStart: true
                running: !root.showTranslate
                onTriggered: root.refreshPlayers()
            }

            LyricsContent {
                id: lyricsWidget
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                height: implicitHeight
                player: root.currentPlayer
                active: root.isLyricsMode && root.currentPlayer !== null
                opacity: root.isLyricsMode && !root.lyricsPeek ? 1 : 0
                visible: opacity > 0.01
                Behavior on opacity { NumberAnimation { duration: 250 } }
            }

            TranslationContent {
                id: translatorWidget
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: Math.min(implicitWidth, parent.width)
                height: implicitHeight
                opacity: root.showTranslate ? 1 : 0
                visible: opacity > 0.01
                Behavior on opacity { NumberAnimation { duration: 250 } }
            }

            Connections {
                target: translatorWidget
                function onStatusStateChanged() {
                    if (translatorWidget.statusState === "exited") root.showTranslate = false
                }
            }

            MouseArea {
                id: islandMouseArea
                z: 3
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: root.isCollapsedMode ? 32 : parent.height
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                acceptedButtons: root.isCollapsedMode ? Qt.NoButton : Qt.LeftButton
                onClicked: {
                    if (root.isCollapsedMode) return
                    root.showLyrics = false
                    root.showTranslate = false
                    translatorWidget.stop()
                    lyricsHideDebounce.stop()
                    root.autoDismissed = true
                }
                onEntered: root.lyricsPeek = false
                onExited: root.lyricsPeek = false
                onPositionChanged: root.lyricsPeek = false
            }

            Timer {
                id: lyricsPeekTimer
                interval: 600; repeat: false
                onTriggered: {
                    if (root.isLyricsMode && islandMouseArea.containsMouse)
                        root.lyricsPeek = true
                }
            }

            Item {
                z: 2
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: 32
                clip: true
                opacity: (root.isCollapsedMode && root.isCollapsedHovered) || root.lyricsPeek ? 1 : 0
                visible: opacity > 0.01
                Behavior on opacity { NumberAnimation { duration: 300 } }

                Row {
                    id: collapsedButtons
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    spacing: 8

                    Rectangle {
                        id: translateBtn
                        width: 28; height: 28; radius: 14
                        color: root.showTranslate ? Appearance.colors.colPrimary
                            : (translateMouse.containsMouse ? Appearance.colors.nord3 : Appearance.colors.nord1)
                        Behavior on color { ColorAnimation { duration: 150 } }
                        Text {
                            anchors.centerIn: parent
                            text: "译"
                            color: root.showTranslate ? Appearance.colors.colText : Appearance.colors.colTextSub
                            font.family: Sizes.fontFamily; font.pixelSize: 11
                        }
                        MouseArea {
                            id: translateMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (root.showTranslate) {
                                    root.showTranslate = false; translatorWidget.stop()
                                } else {
                                    root.showLyrics = false; lyricsHideDebounce.stop()
                                    root.showTranslate = true; translatorWidget.start()
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: lyricsBtn
                        width: 28; height: 28; radius: 14
                        color: root.isLyricsMode ? Appearance.colors.colPrimary
                            : (lyricsMouse.containsMouse ? Appearance.colors.nord3 : Appearance.colors.nord1)
                        Behavior on color { ColorAnimation { duration: 150 } }
                        Text {
                            anchors.centerIn: parent
                            text: "词"
                            color: root.isLyricsMode ? Appearance.colors.colText : Appearance.colors.colTextSub
                            font.family: Sizes.fontFamily; font.pixelSize: 11
                        }
                        MouseArea {
                            id: lyricsMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (root.isLyricsMode) {
                                    root.showLyrics = false; lyricsHideDebounce.stop()
                                    root.autoDismissed = true
                                } else {
                                    root.showTranslate = false; translatorWidget.stop()
                                    root.showLyrics = true; root.autoDismissed = false
                                    lyricsHideDebounce.stop()
                                }
                            }
                        }
                    }
                }

                ClockContent {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 16
                    width: 110; height: 28
                }
            }
        }
    }
}
