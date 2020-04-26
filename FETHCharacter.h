#pragma once

#include "FETHGrowthRates.h"
#include "FETHClass.h"

#include <QObject>
#include <QDebug>

class FETHCharacter final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* baseGrowthRates READ getBaseGrowthRates CONSTANT FINAL)

public:
    FETHCharacter(const QString& name, data::GrowthRates baseGrowthRates) : _name(name), _baseGrowthRates(baseGrowthRates)
    {

    }

    QString getName() const { return _name; }
    FETHGrowthRates* getBaseGrowthRates()
    {
        return &_baseGrowthRates;
    }

private:
    const QString _name;
    FETHGrowthRates _baseGrowthRates; // TODO const
};
