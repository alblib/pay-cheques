#include "preferencesdialog.h"
#include "ui_preferencesdialog.h"
#include "authdialog.h"

PreferencesDialog::PreferencesDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::PreferencesDialog)
{
    ui->setupUi(this);
}

PreferencesDialog::~PreferencesDialog()
{
    delete ui;
}

void PreferencesDialog::on_pushButton_clicked()
{
    AuthDialog(this).exec();
}
