#include "PaymentDayElement.h"
#include <cmath>

QString PaymentDayElement::itoa(int i)
{
    char buffer[int(std::log10(i)) + 3];
    std::sprintf(buffer,"%d",i);
    return buffer;
}

PaymentDayElement::PaymentDayElement(int payment_day):
    _payment_day(payment_day)
{

}

QString PaymentDayElement::paymentDayString() const
{
    return itoa(_payment_day) + "일";
}

bool PaymentDayElement::operator ==(int payment_day_int)
{
    return payment_day_int == _payment_day;
}

bool PaymentDayElement::operator ==(const QString &payment_str)
{
    return payment_str == paymentDayString();
}

QDate PaymentDayElement::nextPayment(const QDate &date) const
{
    QDate result(date.year(), date.month(), _payment_day);
    if (date < result) result = result.addMonths(1);
    return result;
}

FixedPaymentDayElement::FixedPaymentDayElement
(int payment_day, int using_start_day):
    PaymentDayElement(payment_day), _using_start_day(using_start_day)
{

}

QString FixedPaymentDayElement::usingDayString() const
{
    if(_using_start_day == 1) return "전월 1일 ~ 전월 말일";
    QString start = itoa(_using_start_day) + "일",
            end = itoa(_using_start_day - 1) + "일";
    if(_using_start_day == 31) start = "말일";
    if (_payment_day < _using_start_day){
        return QString("전전월 ") + itoa(_using_start_day)
                + QString("일 ~ 전전월 ")
                + itoa(_using_start_day - 1) + "일";
    }else {
        return QString("전월 ") + itoa(_using_start_day)
                + QString("일 ~ 당월 ")
                + itoa(_using_start_day - 1) + "일";
    }
}

QDate FixedPaymentDayElement::paymentDayBy(const QDate &usedDay) const
{
    QDate temp(usedDay.year(), usedDay.month(), _using_start_day);
    if (temp <= usedDay){
        temp = temp.addMonths(1);
        temp = QDate(temp.year(), temp.month(), _using_start_day);
    }
    QDate result(temp.year(), temp.month(), _payment_day);
    if (result < temp){
        result = result.addMonths(1);
        result = QDate(result.year(), result.month(), _payment_day);
    }
    return result;
}
/*
QPair<QDate> FixedPaymentDayElement::usedDaysBy(const QDate &payedDay) const
{

}
*/
