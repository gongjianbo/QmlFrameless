#ifndef FRAMELESSTOOL_H
#define FRAMELESSTOOL_H

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

private:
    QWindow *window = nullptr;
};

#endif // FRAMELESSTOOL_H
