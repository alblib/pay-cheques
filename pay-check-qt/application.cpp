#include "application.h"
#include <QMessageBox>

Application::Application(int &argc, char **argv):QApplication(argc, argv, true)
{
    _singular = new QSharedMemory("MyVeryUniqueName", this);
    if(!lock()){
        QMessageBox::critical(0, "Error", "Application allready running");
        exit(1);
    }
}

Application::~Application()
{
    if(_singular->isAttached())
    _singular->detach();
}

bool Application::lock()
{
    if(_singular->attach(QSharedMemory::ReadOnly)){
    _singular->detach();
    return false;
    }

    if(_singular->create(1))
    return true;

    return false;
}
