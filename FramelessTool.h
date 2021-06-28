#pragma once
#include <QObject>
#include <QCursor>
#include <QWindow>
#include <QQmlEngine>

//qml中有些函数调用不便或者无法调用
class FramelessTool : public QObject
{
    Q_OBJECT
private:
    explicit FramelessTool(QObject *parent = nullptr);
public:
    static FramelessTool *getInstance();
    static QObject *singletonProvider(QQmlEngine* engine, QJSEngine* scriptEngine);

    //QCursor::pos
    Q_INVOKABLE static QPoint pos();
    //QGuiApplication::setOverrideCursor
    Q_INVOKABLE static void setOverrideCursor(Qt::CursorShape shape);
    //QGuiApplication::restoreOverrideCursor
    Q_INVOKABLE static void restoreOverrideCursor();

    //使用win32操作winId
    //（qml设置window在最大化时showMin可能无法恢复显示）
    Q_INVOKABLE void showMax(QWindow *window);
    Q_INVOKABLE void showMin(QWindow *window);
    Q_INVOKABLE void showNormal(QWindow *window);
};
