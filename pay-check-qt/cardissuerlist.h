#ifndef CARDISSUERLIST_H
#define CARDISSUERLIST_H

#include <QComboBox>

class CardIssuerList : public QComboBox
{
    Q_OBJECT
public:
    CardIssuerList(QWidget *parent = Q_NULLPTR);
};

#endif // CARDISSUERLIST_H
