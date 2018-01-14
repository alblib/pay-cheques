#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <preferencesdialog.h>
#include <application.h>
#include <aboutdialog.h>
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::closeEvent(QCloseEvent *event){
    //QMessageBox::
    //event->accept();
}

void MainWindow::on_action_Preferences_triggered()
{
    PreferencesDialog(this).exec();
}

void MainWindow::on_action_Quit_triggered()
{
    Application::quit();
}

void MainWindow::on_actionAbout_triggered()
{/*
    QQuickView view;
    view.setSource(QUrl::fromLocalFile("About.qml"));
    view.show();
    QObject *object = view.rootObject();
   */ AboutDialog(this).exec();
}
