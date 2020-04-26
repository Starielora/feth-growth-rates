#pragma once

#include "FETHGrowthRates.h"

#include <QObject>
#include <QDebug>

class FETHClass final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* growthRates READ getGrowthRates CONSTANT FINAL)

public:

    FETHClass(const QString& name, data::GrowthRates growthRates) : _name(name), _growthRates(growthRates)
    {

    }

    ~FETHClass()
    {
        qDebug() << "Deleting" << _name;
    }

    QString getName() const { return _name; }
    FETHGrowthRates* getGrowthRates() { return &_growthRates; }

private:
    const QString _name;
    FETHGrowthRates _growthRates; // TODO const
};
