#ifndef KOREANCARDISSUER_H
#define KOREANCARDISSUER_H

#include <QStringList>
#include <initializer_list>
#include <QComboBox>
#include <QLabel>

using std::initializer_list;

struct KoreanCardIssuer
{
public:
    struct qPaymentPair{
        int payment_day, use_start_day;
        qPaymentPair() = delete;
        qPaymentPair(int payment_day, int use_start_day);
        qPaymentPair(initializer_list<int> list);
    };
    QList<qPaymentPair> installment_days;
    QString issuer;
    KoreanCardIssuer(const QString& issuer);
    KoreanCardIssuer(const QString& issuer, initializer_list<initializer_list<int>> list);
    KoreanCardIssuer(const QString &issuer, int payment_for_whole, int payment_end);
    int using_start_day(int payment_day) const;
    int& using_start_day(int payment_day);
    void erase_payment_day(int payment_day);
    QString using_days_string_from_index(int index) const;
    QString using_days_string(int payment_day) const;
    QStringList payment_days_string() const;
    void set_payment_day_combobox(QComboBox& combobox);
    QString label_string_from_combobox_string(const QString& payment_str);
    void set_using_days_label_from_combobox(QComboBox& combobox, QLabel& label);
};

class KoreanCardComboBox: public QComboBox
{
public:
    QList<KoreanCardIssuer> list;
    KoreanCardComboBox(QWidget *parent = Q_NULLPTR);
};

#endif // KOREANCARDISSUER_H
