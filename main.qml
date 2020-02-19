import QtQuick 2.12
import QtQuick.Window 2.12
import StephenQuan 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Syntax Highlighter Sample")

    TextEdit {
        id: textEdit
        anchors.fill: parent
        anchors.margins: 10
        selectByMouse: true
        text: [
            "import QtQuick 2.12",
            "",
            "Item {",
            "    Rectangle {",
            "        width: 50",
            "        height: 50",
            "        color: '#800000'",
            "    }",
            "}",
        ].join("\n") + "\n"
        font.pointSize: 12
    }

    SyntaxHighlighter {
        id: syntaxHighlighter
        textDocument: textEdit.textDocument
        onHighlightBlock: {
            let rx = /\/\/.*|[A-Za-z.]+(\s*:)?|\d+(.\d*)?|'[^']*?'|"[^"]*?"/g
            let m
            while ( ( m = rx.exec(text) ) !== null ) {
                if (m[0].match(/^\/\/.*/)) {
                    setFormat(m.index, m[0].length, commentFormat);
                    continue;
                }
                if (m[0].match(/^[a-z][A-Za-z.]*\s*:/)) {
                    setFormat(m.index, m[0].match(/^[a-z][A-Za-z.]*/)[0].length, propertyFormat);
                    continue;
                }
                if (m[0].match(/^[a-z]/)) {
                    let keywords = [ 'import', 'function', 'bool', 'var',
                                    'int', 'string', 'let', 'const', 'property',
                                    'if', 'continue', 'for', 'break', 'while',
                        ]
                    if (keywords.includes(m[0])) {
                        setFormat(m.index, m[0].length, keywordFormat);
                        continue;
                    }
                    continue;
                }
                if (m[0].match(/^[A-Z]/)) {
                    setFormat(m.index, m[0].length, componentFormat);
                    continue;
                }
                if (m[0].match(/^\d/)) {
                    setFormat(m.index, m[0].length, numberFormat);
                    continue;
                }
                if (m[0].match(/^'/)) {
                    setFormat(m.index, m[0].length, stringFormat);
                    continue;
                }
                if (m[0].match(/^"/)) {
                    setFormat(m.index, m[0].length, stringFormat);
                    continue;
                }
            }
        }

    }

    TextCharFormat { id: keywordFormat; foreground: "#808000" }
    TextCharFormat { id: componentFormat; foreground: "#aa00aa"; font.pointSize: 12; font.bold: true; font.italic: true }
    TextCharFormat { id: numberFormat; foreground: "#0055af" }
    TextCharFormat { id: propertyFormat; foreground: "#800000" }
    TextCharFormat { id: stringFormat; foreground: "green" }
    TextCharFormat { id: commentFormat; foreground: "green" }

}
