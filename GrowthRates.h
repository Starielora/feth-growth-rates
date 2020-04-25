#pragma once

#include <cstdint>

#include <QObject>

namespace data
{
    struct GrowthRates
    {
        const std::int32_t hp;
        const std::int32_t str;
        const std::int32_t mag;
        const std::int32_t dex;
        const std::int32_t spd;
        const std::int32_t lck;
        const std::int32_t def;
        const std::int32_t res;
        const std::int32_t charm;
    };
}

class GrowthRates final : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qint32 hp READ getHp CONSTANT FINAL)
    Q_PROPERTY(qint32 str READ getStr CONSTANT FINAL)
    Q_PROPERTY(qint32 mag READ getMag CONSTANT FINAL)
    Q_PROPERTY(qint32 dex READ getDex CONSTANT FINAL)
    Q_PROPERTY(qint32 spd READ getSpd CONSTANT FINAL)
    Q_PROPERTY(qint32 lck READ getLck CONSTANT FINAL)
    Q_PROPERTY(qint32 def READ getDef CONSTANT FINAL)
    Q_PROPERTY(qint32 res READ getRes CONSTANT FINAL)
    Q_PROPERTY(qint32 charm READ getCharm CONSTANT FINAL)

public:
    GrowthRates(data::GrowthRates data) : _data(data)
    {

    }

    qint32 getHp() { return _data.hp; }
    qint32 getStr() { return _data.str; }
    qint32 getMag() { return _data.mag; }
    qint32 getDex() { return _data.dex; }
    qint32 getSpd() { return _data.spd; }
    qint32 getLck() { return _data.lck; }
    qint32 getDef() { return _data.def; }
    qint32 getRes() { return _data.res; }
    qint32 getCharm() { return _data.charm; }

private:
    const data::GrowthRates _data;
};
