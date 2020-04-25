#pragma once

#include "GrowthRates.h"

#include <QObject>
#include <QDebug>

class FEClass final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(GrowthRates* growthRates READ getGrowthRates CONSTANT FINAL)

public:

    FEClass(const QString& name, data::GrowthRates growthRates) : _name(name), _growthRates(growthRates)
    {

    }

    ~FEClass()
    {
        qDebug() << "Deleting" << _name;
    }

    QString getName() const { return _name; }
    GrowthRates* getGrowthRates() { return &_growthRates; }

private:
    const QString _name;
    GrowthRates _growthRates; // TODO const
};
