#include "FramelessTool.h"
#include <QGuiApplication>
//LIBS += -luser32
#include <Windows.h>
#include <QDebug>

FramelessTool::FramelessTool(QObject *parent)
    : QObject(parent)
{
}

FramelessTool *FramelessTool::getInstance()
{
    static FramelessTool *instance = nullptr;
    if(!instance){
        instance = new FramelessTool(qApp);
    }
    return instance;
}

QObject *FramelessTool::singletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return getInstance();
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

void FramelessTool::showMax(QWindow *window)
{
    if(window){
        //window->showMaximized();
        ::ShowWindow((HWND)window->winId(),SW_SHOWMAXIMIZED);
    }
}

void FramelessTool::showMin(QWindow *window)
{
    if(window){
        //window->showMinimized();
        ::ShowWindow((HWND)window->winId(),SW_SHOWMINIMIZED);
    }
}

void FramelessTool::showNormal(QWindow *window)
{
    if(window){
        //window->showNormal();
        ::ShowWindow((HWND)window->winId(),SW_SHOWNORMAL);
    }
}
