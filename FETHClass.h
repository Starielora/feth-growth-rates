#pragma once

#include <QObject>

#include <memory>

class FETHGrowthRates;

class FETHClass final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* growthRates READ getGrowthRates CONSTANT FINAL)
    Q_PROPERTY(QString type READ getType CONSTANT FINAL)

public:

    FETHClass(const QString& name, const QString& type, std::shared_ptr<FETHGrowthRates> growthRates) : _name(name), _type(type), _growthRates(std::move(growthRates))
    {

    }

    QString getName() const { return _name; }
    QString getType() const { return _type; }
    FETHGrowthRates* getGrowthRates() { return _growthRates.get(); }

private:
    const QString _name;
    const QString _type;
    const std::shared_ptr<FETHGrowthRates> _growthRates;
};
