#include "mainwindow.h"
#include <application.h>
int main(int argc, char *argv[])
{
    Application app(argc, argv);
    app.setApplicationName("Pay Cheques");
    app.setApplicationDisplayName("Pay Cheques");
    MainWindow w;
    w.show();

    return app.exec();
}
