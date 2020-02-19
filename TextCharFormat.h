#ifndef TextCharFormat_H
#define TextCharFormat_H

#include <QObject>
#include <QTextCharFormat>

class TextCharFormat : public QObject, public QTextCharFormat
{
    Q_OBJECT

    Q_PROPERTY (QFont font READ font WRITE setFont NOTIFY fontChanged)
    Q_PROPERTY (QVariant foreground READ foreground WRITE setForeground NOTIFY foregroundChanged)

public:
    TextCharFormat(QObject* parent = nullptr);

signals:
    void fontChanged();
    void foregroundChanged();

protected:
    void setFont(const QFont& font);
    QFont font() const;

    QVariant foreground() const;
    void setForeground(const QVariant& foreground);

};

#endif
