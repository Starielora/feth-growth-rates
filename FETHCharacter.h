#pragma once

#include <QObject>

#include <memory>

class FETHGrowthRates;

class FETHCharacter final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ getName CONSTANT FINAL)
    Q_PROPERTY(FETHGrowthRates* baseGrowthRates READ getBaseGrowthRates CONSTANT FINAL)
    Q_PROPERTY(QString house READ getHouse CONSTANT FINAL)

public:
    FETHCharacter(const QString& name, const QString& house , std::shared_ptr<FETHGrowthRates> growthRates) : _name(name), _house(house), _baseGrowthRates(std::move(growthRates))
    {

    }

    QString getName() const { return _name; }
    QString getHouse() const { return _house; }
    FETHGrowthRates* getBaseGrowthRates()
    {
        return _baseGrowthRates.get();
    }

    quint16 getHouseOrderIndex() const // TODO decide how to handle orders
    {
        if(_house == "Protagonist") return 0;
        else if(_house == "Black Eagles") return 1;
        else if(_house == "Blue Lions") return 2;
        else if(_house == "Golden Deer") return 3;
        else if(_house == "Ashen Wolves") return 4;
        else if(_house == "Church of Seiros") return 5;
        else if(_house == "Knights of Seiros") return 6;
        else if(_house == "Other") return 7;
        else return 8;
    }


private:
    const QString _name;
    const std::shared_ptr<FETHGrowthRates> _baseGrowthRates;
    const QString _house;
};
