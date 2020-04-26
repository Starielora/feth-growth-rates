#pragma once

#include "GrowthRates.h"
#include "FEClass.h"

#include <QObject>
#include <QDebug>

class Character final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(GrowthRates* baseGrowthRates READ getBaseGrowthRates CONSTANT FINAL)

public:
    Character(const QString& name, data::GrowthRates baseGrowthRates) : _name(name), _baseGrowthRates(baseGrowthRates)
    {

    }

    ~Character()
    {
        qDebug() << "Deleting" << _name;
    }

    QString getName() const { return _name; }
    GrowthRates* getBaseGrowthRates()
    {
        return &_baseGrowthRates;
    }

private:
    const QString _name;
    GrowthRates _baseGrowthRates; // TODO const
};
