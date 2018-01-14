#-------------------------------------------------
#
# Project created by QtCreator 2018-01-02T18:54:40
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
QT += webenginewidgets network networkauth

TARGET = pay-check-qt
TEMPLATE = app

macx:ICON = icons/AppIcon.icns


VERSION = 0.4.0.1
QMAKE_TARGET_COMPANY = "Protelum Liberium"
QMAKE_TARGET_PRODUCT = "Pay Cheques"
QMAKE_TARGET_DESCRIPTION = "description"
QMAKE_TARGET_COPYRIGHT = "Albertus Liberius"

DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        mainwindow.cpp \
    application.cpp \
    preferencesdialog.cpp \
    koreancardissuer.cpp \
    PaymentDayElement.cpp \
    cardissuerlist.cpp \
    aboutdialog.cpp \
    authdialog.cpp

HEADERS += \
        mainwindow.h \
    application.h \
    preferencesdialog.h \
    koreancardissuer.h \
    PaymentDayElement.h \
    cardissuerlist.h \
    aboutdialog.h \
    authdialog.h

FORMS += \
        mainwindow.ui \
    preferencesdialog.ui \
    aboutdialog.ui \
    authdialog.ui

DISTFILES += \
    icons/AppIcon.icns \
    AuthWindow.qml

RESOURCES += \
    appicon.qrc
