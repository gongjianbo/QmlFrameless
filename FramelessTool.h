#pragma once
#include <QObject>
#include <QCursor>
#include <QWindow>

//qml中有些函数调用不便或者无法调用
class FramelessTool : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QWindow *window MEMBER window)
public:
    explicit FramelessTool(QObject *parent = nullptr);

    //QCursor::pos
    Q_INVOKABLE static QPoint pos();
    //QGuiApplication::setOverrideCursor
    Q_INVOKABLE static void setOverrideCursor(Qt::CursorShape shape);
    //QGuiApplication::restoreOverrideCursor
    Q_INVOKABLE static void restoreOverrideCursor();

    //使用win32操作winId
    Q_INVOKABLE void showMax();
    Q_INVOKABLE void showMin();
    Q_INVOKABLE void showNormal();

private:
    QWindow *window = nullptr;
};
