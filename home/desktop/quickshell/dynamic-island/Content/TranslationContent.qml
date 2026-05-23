import QtQuick
import Quickshell
import Quickshell.Io
import "../Common"
import "."

Item {
    id: root

    property string partialText: ""
    property string finalText: ""
    property string translatedText: ""
    property string statusState: "idle"

    readonly property bool isActive: translatorProcess.running

    implicitWidth: 380
    implicitHeight: isActive || statusState === "nobin" ? 90 : 0

    function start() {
        if (!TranslationConfig.binValid) {
            root.statusState = "nobin"
            return
        }
        translatorProcess.running = true
    }
    function stop()  {
        translatorProcess.running = false
        root.statusState = "idle"
    }

    Process {
        id: translatorProcess
        command: TranslationConfig.command()
        running: false

        stdout: SplitParser {
            onRead: data => {
                try {
                    var msg = JSON.parse(data)
                    switch (msg.type) {
                        case "partial": root.partialText = msg.text; break
                        case "final":
                            root.finalText = msg.text
                            root.translatedText = msg.translated
                            root.partialText = ""
                            break
                        case "status": root.statusState = msg.state; break
                        case "error": root.translatedText = msg.message; break
                    }
                } catch (e) { console.warn("TranslationContent: parse error", data) }
            }
        }

        onExited: {
            root.statusState = "exited"
            root.partialText = ""
        }
    }

    Item {
        anchors.fill: parent
        clip: true

        Column {
            anchors.centerIn: parent
            width: parent.width - 24
            spacing: 4

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: {
                    switch (root.statusState) {
                        case "idle": return "启动中..."
                        case "listening": return "收听中..."
                        case "exited": return "已停止"
                        case "nobin": return "二进制不存在"
                        default: return root.statusState
                    }
                }
                color: root.statusState === "nobin" ? Appearance.colors.nord11 : Appearance.colors.colTextSub
                font.family: Sizes.fontFamily
                font.pixelSize: 11
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: root.partialText
                color: Appearance.colors.colTextSub
                font.family: Sizes.fontFamily
                font.pixelSize: 14
                font.italic: true
                visible: root.partialText !== ""
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "请配置后端二进制路径"
                color: Appearance.colors.colTextSub
                font.family: Sizes.fontFamily
                font.pixelSize: 12
                visible: root.statusState === "nobin"
                elide: Text.ElideRight
            }
            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: TranslationConfig.bin
                color: Appearance.colors.nord11
                font.family: Sizes.fontFamily
                font.pixelSize: 11
                font.italic: true
                visible: root.statusState === "nobin"
                elide: Text.ElideMiddle
            }

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: root.finalText
                color: Appearance.colors.colPrimary
                font.family: Sizes.fontFamily
                font.pixelSize: 13
                visible: root.finalText !== ""
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: root.translatedText
                color: Appearance.colors.colText
                font.family: Sizes.fontFamily
                font.pixelSize: 16
                font.weight: Font.Bold
                visible: root.translatedText !== ""
                elide: Text.ElideRight
            }
        }
    }
}
