pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    readonly property string srcLang: "en"
    readonly property string tgtLang: "zh"
    readonly property string audioDevice: "pw:alsa_output.pci-0000_03_00.6.HiFi__Speaker__sink"
    readonly property string modelDir: "/home/lznauy/live-translator/models"
    readonly property string bin: modelDir + "/../target/release/live-translator"

    property bool binValid: false

    function command() {
        return [
            bin,
            "--auto-start",
            "--auto-src", srcLang,
            "--auto-tgt", tgtLang,
            "--vad-model", modelDir + "/silero_vad.onnx",
            "--asr-model", modelDir + "/sensevoice.onnx",
            "--asr-tokens", modelDir + "/tokens.txt",
            "--nllb-model", modelDir + "/nllb-600M",
            "--audio-device", audioDevice,
        ]
    }

    property var _checker: Process {
        id: checker
        command: ["test", "-f", TranslationConfig.bin]
        running: true
        onExited: { TranslationConfig.binValid = (checker.exitCode === 0) }
    }

    function checkBin() {
        checker.running = false
        checker.running = true
    }
}
