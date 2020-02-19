#ifndef SyntaxHighlighter_H
#define SyntaxHighlighter_H

#include <QObject>
#include <QTextDocument>
#include <QSyntaxHighlighter>
#include <QQuickTextDocument>
#include "TextCharFormat.h"

class SyntaxHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument* textDocument READ textDocument WRITE setTextDocument NOTIFY textDocumentChanged)

public:
    SyntaxHighlighter(QObject* parent = nullptr);

    Q_INVOKABLE void setFormat(int start, int count, const QVariant& format);

signals:
    void textDocumentChanged();
    void highlightBlock(const QVariant& text);

protected:
    QQuickTextDocument* m_TextDocument;

    QQuickTextDocument* textDocument() const;
    void setTextDocument(QQuickTextDocument* textDocument);

    virtual void highlightBlock(const QString &text);

};

#endif
