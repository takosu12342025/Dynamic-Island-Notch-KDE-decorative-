import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    toolTipMainText: ""
    toolTipSubText: ""

    // 設定項目のリアルタイムバインド
    readonly property int currentType: Plasmoid.configuration.notchType
    readonly property int targetWidth: Plasmoid.configuration.notchWidth
    readonly property int targetHeight: Plasmoid.configuration.notchHeight

    // パネル内での幅・高さを同期
    Layout.preferredWidth: targetWidth
    Layout.preferredHeight: targetHeight
    Layout.fillHeight: false

    fullRepresentation: Item {
        width: 0
        height: 0
    }

    compactRepresentation: Item {
        id: container
        width: targetWidth
        height: targetHeight

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: (mouse) => mouse.accepted = false
            onReleased: (mouse) => mouse.accepted = false
            onClicked: (mouse) => mouse.accepted = false
        }

        Rectangle {
            id: notchBody
            width: targetWidth
            height: targetHeight
            
            // ノッチ型なら上端密着(y=0)、アイランド型なら少し(6px)浮かす位置に強制逆算
            x: 0
            y: currentType === 0 ? -container.mapToItem(null, 0, 0).y : -container.mapToItem(null, 0, 0).y + 6
            
            color: "#000000"
            // アイランド型の場合は縦幅に応じた綺麗な完全角丸(カプセル型)にする
            radius: currentType === 0 ? 12 : targetHeight / 2

            // ノッチ型の時だけ、上半分を四角で隠して上端をフラットにする
            Rectangle {
                width: parent.width
                height: parent.height / 2
                color: "#000000"
                anchors.top: parent.top
                visible: root.currentType === 0
            }
        }
    }
}
