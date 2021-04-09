import QtQuick 2.12
import QtQuick.Controls 2.12

//继承WindowMove实现标题栏
WindowMove {
    id: control

    Row{
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            margins: 10
        }
        spacing: 10

        Button{
            width: 60
            height: 26
            text: "min"
            onClicked: {
                //root.showMinimized(); --qt bug
                control.tool.showMin();
            }
        }
        Button{
            width: 60
            height: 26
            text: "max"
            onClicked: {
                if(window_resize.isMax){
                    root.showNormal();
                }else{
                    root.showMaximized();
                }
            }
        }
        Button{
            width: 60
            height: 26
            text: "quit"
            onClicked: {
                Qt.quit();
            }
        }
    }
}
