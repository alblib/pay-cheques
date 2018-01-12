#include "koreancardissuer.h"
#include <algorithm>
#include <cstdlib>
#include <stdexcept>

KoreanCardIssuer::qPaymentPair::qPaymentPair
(int payment_day, int use_start_day):
    payment_day(payment_day), use_start_day(use_start_day)
{

}

KoreanCardIssuer::qPaymentPair::qPaymentPair(std::initializer_list<int> list)
{
    if (list.size() != 2) throw std::out_of_range("");
    payment_day = *list.begin();
    use_start_day = *(list.begin()+1);
}

KoreanCardIssuer::KoreanCardIssuer(const QString& issuer): issuer(issuer)
{

}

KoreanCardIssuer::KoreanCardIssuer
(const QString &issuer, std::initializer_list<std::initializer_list<int>> list):
    issuer(issuer)
{
    foreach(const initializer_list<int>& op, list){
        installment_days << qPaymentPair(op);
    }
}

KoreanCardIssuer::KoreanCardIssuer(const QString &issuer, int payment_for_whole, int payment_end):
    installment_days(), issuer(issuer)
{
    int i;
    for(i = 1; i < payment_for_whole; ++i){
        installment_days << qPaymentPair(i,i+31-payment_for_whole);
    }for (; i <= payment_end; ++i){
        installment_days << qPaymentPair(i, i + 1 - payment_for_whole);
    }
}

int KoreanCardIssuer::using_start_day(int payment_day) const
{
    return std::find_if(installment_days.begin(), installment_days.end(), [payment_day](const qPaymentPair& pair)->bool{return pair.payment_day == payment_day;}) -> use_start_day;
}

int &KoreanCardIssuer::using_start_day(int payment_day)
{
    return std::find_if(installment_days.begin(), installment_days.end(), [payment_day](const qPaymentPair& pair)->bool{return pair.payment_day == payment_day;}) -> use_start_day;
}

void KoreanCardIssuer::erase_payment_day(int payment_day)
{
    installment_days.erase(std::find_if(installment_days.begin(), installment_days.end(), [payment_day](const qPaymentPair& pair)->bool{return pair.payment_day == payment_day;}));
}

QString KoreanCardIssuer::using_days_string_from_index(int index) const
{
    const int start_day = installment_days[index].use_start_day;
    constexpr auto itoa = [](int day) -> QString {char buffer[3]; std::sprintf(buffer,"%d",day); return QString(buffer);};
    if (start_day == 1){
        return QString("1일 ~ 말일");
    }else{
        return itoa(start_day) + QString("일 ~ 다음달 ") + itoa(start_day - 1) + QString("일");
    }
}

QString KoreanCardIssuer::using_days_string(int payment_day) const
{
    const int start_day = using_start_day(payment_day);
    constexpr auto itoa = [](int day) -> QString {char buffer[3]; std::sprintf(buffer,"%d",day); return QString(buffer);};
    if (start_day == 1){
        return QString("1일 ~ 말일");
    }else{
        return itoa(start_day) + QString("일 ~ 다음달 ") + itoa(start_day - 1) + QString("일");
    }
}

QStringList KoreanCardIssuer::payment_days_string() const
{
    const auto itoa = [](int day) -> QString {char buffer[3]; std::sprintf(buffer,"%d",day); return QString(buffer);};
    QStringList result;
    foreach (qPaymentPair qpair, installment_days){
        result += itoa(qpair.payment_day);
    }
    return result;
}

void KoreanCardIssuer::set_payment_day_combobox(QComboBox &combobox)
{
    combobox.clear();
    combobox.addItems(payment_days_string());
}

QString KoreanCardIssuer::label_string_from_combobox_string(const QString &payment_str)
{
    const auto list = payment_days_string();
    return using_days_string_from_index(std::find(list.begin(), list.end(), payment_str) - list.begin());
}

void KoreanCardIssuer::set_using_days_label_from_combobox(QComboBox &combobox, QLabel &label)
{
    label.setText(using_days_string_from_index(combobox.currentIndex()));
}

KoreanCardComboBox::KoreanCardComboBox(QWidget *parent):
    QComboBox(parent), list()
{
    list << KoreanCardIssuer("IBK기업카드",15,27);
    list.back().using_start_day(14) = 31;
    list << KoreanCardIssuer("KB국민카드",14,27);
    list << KoreanCardIssuer("하나카드",13,27);
    list.back().erase_payment_day(2);
    list.back().erase_payment_day(3);
    list.back().erase_payment_day(4);
    list.back().erase_payment_day(6);
    list.back().erase_payment_day(9);
    list.back().erase_payment_day(11);
    list.back().erase_payment_day(16);
    list.back().erase_payment_day(19);
    list.back().erase_payment_day(22);
    list.back().erase_payment_day(24);
    list.back().erase_payment_day(26);
}

