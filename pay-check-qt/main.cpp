#include "mainwindow.h"
#include <application.h>
int main(int argc, char *argv[])
{
    Application app(argc, argv);

    MainWindow w;
#ifdef Q_OS_MAC
    w.setWindowIcon(QIcon("../icons/AppIcon.icns"));
#endif
    w.show();

    return app.exec();
}
