import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12

//无边框橡皮筋预览窗口
//如果resize有闪烁/黑屏现象，可以替换为widgets的窗口作为rubber
Window {
    id: control

    //flags: Qt.FramelessWindowHint | Qt.Popup | Qt.WindowStaysOnTopHint
    flags: Qt.ToolTip | Qt.WindowStaysOnTopHint
    color: "#88222222"

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 2
        border.color: "#222222"
    }

    function cloneGeometry(src,obj){
        let rect = Qt.rect(src.x,src.y,src.width,src.height);
        //obj.visibility = src.visibility;
        obj.setGeometry(rect);
    }
}
