#include "FramelessTool.h"
#include <QGuiApplication>
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
