#include "aboutdialog.h"
#include "ui_aboutdialog.h"
#include "application.h"
#include <QMenuBar>

AboutDialog::AboutDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AboutDialog)
{
    ui->setupUi(this);
    ui->nameLabel->setText(Application::applicationName());
    ui->versionLabel->setText("Version " + Application::applicationVersion());
    //setWindowFlags(Qt::Dialog | Qt::CustomizeWindowHint | Qt::WindowTitleHint | Qt::WindowSystemMenuHint);
    setFixedSize(width(), height());
    new QShortcut(QKeySequence::Close, this, SLOT(close()));
    new QShortcut(QKeySequence::Quit, this, SLOT(on_action_Quit_triggered()));
}

AboutDialog::~AboutDialog()
{
    delete ui;
}

void AboutDialog::on_action_Quit_triggered()
{
    Application::quit();
}
