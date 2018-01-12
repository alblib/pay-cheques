#ifndef PAYMENTDAYELEMENT_H
#define PAYMENTDAYELEMENT_H

#include <QString>
#include <QDate>
#include <QPair>


class PaymentDayElement
{
protected:
    static QString itoa(int i);
    int _payment_day;
public:
    PaymentDayElement(int payment_day);
    QString paymentDayString() const;
    bool operator == (int payment_day_int);
    bool operator == (const QString& payment_str);
    virtual QString usingDayString() const = 0;
    virtual QDate paymentDayBy(const QDate& usedDay) const = 0;
    //virtual QPair<QDate> usedDaysBy(const QDate& payedDay) const = 0;
    QDate nextPayment(const QDate& date) const;
};

class FixedPaymentDayElement: public PaymentDayElement
{
protected:
    int _using_start_day;
public:
    FixedPaymentDayElement(int payment_day, int using_start_day);
    virtual QString usingDayString() const;
    virtual QDate paymentDayBy(const QDate& usedDay) const;
    //virtual QPair<QDate> usedDaysBy(const QDate& payedDay) const;
};

class Cycle30FixedPaymentDayElement: public FixedPaymentDayElement
{};

class IntervalPaymentDayElement: public PaymentDayElement
{

};


#endif // PAYMENTDAYELEMENT_H
