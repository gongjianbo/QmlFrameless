import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Gt.Tool 1.0

//无边框移动
Item {
    id: control

    //需绑定target操作窗口
    property Window target
    //TODO暂时move不用橡皮筋，放大缩小的预览比较麻烦
    //property Window rubber
    //拖到顶部放大
    property bool autoMax: true
    property bool onMove: false
    property bool onPress: false
    property bool isMax: (target.visibility===Window.Maximized||
                          target.visibility===Window.FullScreen)

    //鼠标屏幕坐标
    property point tempGlobalPos
    //target.pos与global.pos差
    property point tempOffsetPos
    //距离顶部px
    property int tempTopSpace

    Rectangle { anchors.fill: parent; color: "orange"; }

    MouseArea {
        z: -1
        anchors.fill: parent
        onPressed: {
            if(isMax && !autoMax)
                return;

            //mouse offset
            tempGlobalPos = FramelessTool.pos();
            tempOffsetPos = Qt.point(target.x-tempGlobalPos.x,
                                     target.y-tempGlobalPos.y);
            onMove = false;
            onPress = true;
        }
        onReleased: {
            onPress = false;
            if(onMove && autoMax){
                //拖到顶上最大化
                tempTopSpace = target.y-target.screen.virtualY;
                //给定一个区间，支持竖向多屏
                if(tempTopSpace<-1 && tempTopSpace>-control.height){
                    target.y = target.screen.virtualY;
                    target.showMaximized();
                }
            }
            onMove = false;
        }
        onPositionChanged: {
            if(!onMove){
                if(onPress){
                    onMove = true;
                }else{
                    return;
                }
            }

            if(isMax && autoMax){
                //最大化时拖动恢复为普通状态
                let max_wdith = target.width;
                target.showNormal();
                let normal_width = target.width;
                //放大缩小时mouse.x位置比例
                let normal_x = mouse.x/max_wdith*normal_width;
                //console.log(tempOffsetPos.x,tempGlobalPos.x,normal_x)
                //默认作为标题栏，宽度同window宽度==来计算
                tempOffsetPos.x = -normal_x;
            }
            tempGlobalPos = FramelessTool.pos();
            target.x = tempGlobalPos.x+tempOffsetPos.x;
            target.y = tempGlobalPos.y+tempOffsetPos.y;
        }
        onDoubleClicked: {
            //避免触发移动
            onMove = false;
            if(!autoMax)
                return;

            //双击放大缩小
            if(isMax){
                target.showNormal();
            }else{
                target.showMaximized();
            }
        }
    }
}
