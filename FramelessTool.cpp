#include "FramelessTool.h"
#include <QGuiApplication>
//LIBS += -luser32
#include <Windows.h>
#include <QDebug>

FramelessTool::FramelessTool(QObject *parent)
    : QObject(parent)
{

}

QPoint FramelessTool::pos()
{
    return QCursor::pos();
}

void FramelessTool::setOverrideCursor(Qt::CursorShape shape)
{
    QGuiApplication::setOverrideCursor(QCursor(shape));
}

void FramelessTool::restoreOverrideCursor()
{
    QGuiApplication::restoreOverrideCursor();
}

void FramelessTool::showMax()
{
    if(window){
        //window->showMaximized();
        ::ShowWindow((HWND)window->winId(),SW_SHOWMAXIMIZED);
    }
}

void FramelessTool::showMin()
{
    if(window){
        //window->showMinimized();
        ::ShowWindow((HWND)window->winId(),SW_SHOWMINIMIZED);
    }
}

void FramelessTool::showNormal()
{
    if(window){
        //window->showNormal();
        ::ShowWindow((HWND)window->winId(),SW_SHOWNORMAL);
    }
}
