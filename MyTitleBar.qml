import QtQuick 2.12
import QtQuick.Controls 2.12
import Gt.Tool 1.0

//继承WindowMove实现标题栏
WindowMove {
    id: control

    Row {
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            margins: 10
        }
        spacing: 10

        Rectangle{
            width: 26
            height: 26
            radius: height/2
            color: rect_mouse.containsMouse?"green":"gray"
            MouseArea{
                id: rect_mouse
                hoverEnabled: true
                anchors.fill: parent
            }
        }
    }

    Row{
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            margins: 10
        }
        spacing: 10

        Button {
            width: 60
            height: 26
            text: "min"
            onClicked: {
                //root.showMinimized(); --qt bug
                FramelessTool.showMin(root);
            }
        }
        Button {
            width: 60
            height: 26
            text: window_resize.isMax ? "nor" : "max"
            onClicked: {
                if(window_resize.isMax){
                    root.showNormal();
                }else{
                    root.showMaximized();
                }
            }
        }
        //如果没设置hoverEnabled
        //Control会判断上级节点的hoverEnabled，恰好MouseArea默认false
        //所以Button最好主动设置下
        Button{
            id: btn_close
            width: 60
            height: 26
            text: "quit"
            hoverEnabled: true
            onClicked: {
                Qt.quit();
            }
            background: Rectangle{
                color: btn_close.hovered?"red":"gray"
            }
        }
    }
}
