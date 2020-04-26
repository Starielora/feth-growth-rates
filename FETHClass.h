#pragma once

#include <QObject>

#include <memory>

class FETHGrowthRates;

class FETHClass final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* growthRates READ getGrowthRates CONSTANT FINAL)

public:

    FETHClass(const QString& name, std::shared_ptr<FETHGrowthRates> growthRates) : _name(name), _growthRates(std::move(growthRates))
    {

    }

    QString getName() const { return _name; }
    FETHGrowthRates* getGrowthRates() { return _growthRates.get(); }

private:
    const QString _name;
    const std::shared_ptr<FETHGrowthRates> _growthRates;
};
