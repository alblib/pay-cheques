#ifndef AUTHDIALOG_H
#define AUTHDIALOG_H

#include <QDialog>
#include <QWebEngineView>
#include <QResizeEvent>
#include <QShowEvent>
#include <QOAuth2AuthorizationCodeFlow>
#include <QOAuthHttpServerReplyHandler>

namespace Ui {
class AuthDialog;
}

class AuthDialog : public QDialog
{
    Q_OBJECT

public:
    explicit AuthDialog(QWidget *parent = 0);
    ~AuthDialog();

    virtual void showEvent(QShowEvent*);
    virtual void resizeEvent(QResizeEvent*);

private slots:
    void on_actionQuit_triggered();
    void webLoad(const QUrl&);

private:
    Ui::AuthDialog *ui;

    QWebEngineView* view;
    QOAuth2AuthorizationCodeFlow* flow;
    QOAuthHttpServerReplyHandler* replyHandler;
};

#endif // AUTHWINDOW_H
