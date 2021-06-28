import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

//QML自定义无边框
Window {
    id: root
    visible: true
    width: 640
    height: 480
    minimumHeight: 200
    minimumWidth: 300
    title: qsTr("QML Frameless (by GongJianBo 1992)")
    flags: Qt.FramelessWindowHint |
           Qt.Window  |
           Qt.WindowMinMaxButtonsHint |
           Qt.WindowSystemMenuHint

    color: "darkCyan"

    WindowResize {
        id: window_resize
        target: root
        anchors.fill: parent

        MyTitleBar {
            width: parent.width
            height: 40
            target: root
        }
    }
}
