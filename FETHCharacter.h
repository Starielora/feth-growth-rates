#pragma once

#include <QObject>

#include <memory>

class FETHGrowthRates;

class FETHCharacter final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* baseGrowthRates READ getBaseGrowthRates CONSTANT FINAL)

public:
    FETHCharacter(const QString& name,  std::shared_ptr<FETHGrowthRates> growthRates) : _name(name), _baseGrowthRates(std::move(growthRates))
    {

    }

    QString getName() const { return _name; }
    FETHGrowthRates* getBaseGrowthRates()
    {
        return _baseGrowthRates.get();
    }

private:
    const QString _name;
    const std::shared_ptr<FETHGrowthRates> _baseGrowthRates;
};
