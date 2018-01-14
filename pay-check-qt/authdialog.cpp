#include "authdialog.h"
#include "ui_authdialog.h"
#include <application.h>
#include <QShortcut>
#include <QUrl>
#include <QNetworkRequest>
#include <QHttpMultiPart>
#include <QHttpPart>
#include <QDesktopServices>
#include <utility>

AuthDialog::AuthDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AuthDialog)
{
    ui->setupUi(this);
    view = new QWebEngineView(this);
    view->setGeometry(0,0,width(),height());
    new QShortcut(QKeySequence::Close, this, SLOT(close()));
    new QShortcut(QKeySequence::Quit, this, SLOT(on_actionQuit_triggered()));
    flow = new QOAuth2AuthorizationCodeFlow();
    connect(flow, SIGNAL(authorizeWithBrowser(QUrl)), this, SLOT(webLoad(QUrl)));
    flow->setAuthorizationUrl(QUrl("https://www.dropbox.com/oauth2/authorize"));
    flow->setAccessTokenUrl(QUrl("https://www.dropbox.com/oauth2/token"));
    flow->setClientIdentifier("cxvvf5czfzx7rzt");
    flow->setClientIdentifierSharedKey("kl0a9lmww0y44gp");
    replyHandler = new QOAuthHttpServerReplyHandler(8080, this);
    connect(replyHandler, SIGNAL(finished()), this, SLOT(accept()));

    flow->setToken("token");
    flow->setReplyHandler(replyHandler);
    flow->grant();
}

AuthDialog::~AuthDialog()
{
    delete ui;
    delete view;
    delete flow;
}

void AuthDialog::resizeEvent(QResizeEvent *event){
    view->setGeometry(0,0,width(),height());
    event->accept();
}

void AuthDialog::showEvent(QShowEvent *event){
    event->accept();
}

void AuthDialog::on_actionQuit_triggered()
{
    Application::quit();
}

void AuthDialog::webLoad(const QUrl &url){
    view->load(url);
}
