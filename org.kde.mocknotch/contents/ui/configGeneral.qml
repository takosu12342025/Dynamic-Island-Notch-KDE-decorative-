import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: configRoot
    
    // cfg_ から始まるエイリアスを定義することでKDEが自動で設定値をセーブ・ロードします
    property alias cfg_notchType: typeCombo.currentIndex
    property alias cfg_notchWidth: widthSpin.value
    property alias cfg_notchHeight: heightSpin.value

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 10

        Label { text: "形状タイプ:" }
        ComboBox {
            id: typeCombo
            Layout.fillWidth: true
            model: ["ノッチ型 (上部密着)", "アイランド型 (浮遊)"]
        }

        Label { text: "横幅 (px):" }
        SpinBox {
            id: widthSpin
            from: 50
            to: 2000
            stepSize: 10
            editable: true
        }

        Label { text: "縦幅 (px):" }
        SpinBox {
            id: heightSpin
            from: 10
            to: 200
            stepSize: 2
            editable: true
        }
    }
}
