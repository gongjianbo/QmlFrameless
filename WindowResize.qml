import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

//无边框缩放
Item {
    id: control

    //需绑定target及min-max
    property Window target
    property int minWidth: target.minimumWidth
    property int minHeight: target.minimumHeight
    property int handleWidth: 5
    property int handleZ: 100
    property bool onResize: false
    property bool isMax: (target.visibility===Window.Maximized||
                          target.visibility===Window.FullScreen)

    //press时记录原geometry
    property rect tempRect
    //鼠标屏幕坐标
    property point tempGlobalPos
    //mouse.pos与global.pos差
    property point tempOffsetPos
    //计算得到的geometry
    property rect calcRect

    Item{
        z: handleZ
        anchors.fill: parent
        enabled: !isMax
        //左上
        MouseArea{
            width: handleWidth*2
            height: handleWidth*2
            z: 1
            cursorShape: Qt.SizeFDiagCursor
            Rectangle{ anchors.fill: parent; color: "blue" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(true,false,true,false,mouse);
        }
        //右上
        MouseArea{
            anchors.right: parent.right
            width: handleWidth*2
            height: handleWidth*2
            z: 1
            cursorShape: Qt.SizeBDiagCursor
            Rectangle{ anchors.fill: parent; color: "blue" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(true,false,false,true,mouse);
        }
        //左下
        MouseArea{
            anchors.bottom: parent.bottom
            width: handleWidth*2
            height: handleWidth*2
            z: 1
            cursorShape: Qt.SizeBDiagCursor
            Rectangle{ anchors.fill: parent; color: "blue" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(false,true,true,false,mouse);
        }
        //右下
        MouseArea{
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: handleWidth*2
            height: handleWidth*2
            z: 1
            cursorShape: Qt.SizeFDiagCursor
            Rectangle{ anchors.fill: parent; color: "blue" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(false,true,false,true,mouse);
        }
        //上
        MouseArea{
            width: target.width
            height: handleWidth
            cursorShape: Qt.SizeVerCursor
            Rectangle{ anchors.fill: parent; color: "green" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(true,false,false,false,mouse);
        }
        //下
        MouseArea{
            anchors.bottom: parent.bottom
            width: target.width
            height: handleWidth
            cursorShape: Qt.SizeVerCursor
            Rectangle{ anchors.fill: parent; color: "green" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(false,true,false,false,mouse);
        }
        //左
        MouseArea{
            width: handleWidth
            height: target.height
            cursorShape: Qt.SizeHorCursor
            Rectangle{ anchors.fill: parent; color: "green" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(false,false,true,false,mouse);
        }
        //右
        MouseArea{
            anchors.right: parent.right
            width: handleWidth
            height: target.height
            cursorShape: Qt.SizeHorCursor
            Rectangle{ anchors.fill: parent; color: "green" }
            onPressed: beginResize(mouse,cursorShape);
            onReleased: endResize();
            onPositionChanged: doResize(false,false,false,true,mouse);
        }
    }

    function beginResize(mouse,shape){
        //window rect
        tempRect = Qt.rect(target.x,target.y,target.width,target.height);
        calcRect = tempRect;
        //mouse offset
        tempGlobalPos = framelessTool.pos();
        tempOffsetPos = Qt.point(mouse.x-tempGlobalPos.x,
                                 mouse.y-tempGlobalPos.y);
        onResize = true;
        //设置鼠标形状，防止移动到item外部后变形
        framelessTool.setOverrideCursor(shape);
    }

    function endResize(){
        onResize = false;
        framelessTool.restoreOverrideCursor();
    }

    //m-上下左右为bool参数，表示在哪个边移动
    //mouse为MouseEvent
    function doResize(mtop,mbottom,mleft,mright,mouse){
        if(!onResize)
            return;

        tempGlobalPos = framelessTool.pos();
        if(mtop){
            calcRect.y = tempRect.y+tempGlobalPos.y+tempOffsetPos.y;
            if(calcRect.y > tempRect.y+tempRect.height-minHeight)
                calcRect.y = tempRect.y+tempRect.height-minHeight;
            calcRect.height = tempRect.y+tempRect.height-calcRect.y;
        }else if(mbottom){
            calcRect.height = tempRect.height+tempGlobalPos.y+tempOffsetPos.y;
            if(calcRect.height < minHeight)
                calcRect.height = minHeight;
        }

        if(mleft){
            calcRect.x = tempRect.x+tempGlobalPos.x+tempOffsetPos.x;
            if(calcRect.x > tempRect.x+tempRect.width-minWidth)
                calcRect.x = tempRect.x+tempRect.width-minWidth;
            calcRect.width = tempRect.x+tempRect.width-calcRect.x;
        }else if(mright){
            calcRect.width = tempRect.width+tempGlobalPos.x+tempOffsetPos.x;
            if(calcRect.width < minWidth)
                calcRect.width = minWidth;
        }
        target.setGeometry(calcRect);
    }
}
