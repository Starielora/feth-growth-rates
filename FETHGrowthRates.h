#pragma once

#include <QObject>

class FETHGrowthRates final : public QObject
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
    FETHGrowthRates(qint32 hp, qint32 str, qint32 mag, qint32 dex, qint32 spd, qint32 lck, qint32 def, qint32 res, qint32 charm)
        : _hp(hp), _str(str), _mag(mag), _dex(dex), _spd(spd), _lck(lck), _def(def), _res(res), _charm(charm)
    {

    }

    qint32 getHp() { return _hp; }
    qint32 getStr() { return _str; }
    qint32 getMag() { return _mag; }
    qint32 getDex() { return _dex; }
    qint32 getSpd() { return _spd; }
    qint32 getLck() { return _lck; }
    qint32 getDef() { return _def; }
    qint32 getRes() { return _res; }
    qint32 getCharm() { return _charm; }

private:
    const qint32 _hp;
    const qint32 _str;
    const qint32 _mag;
    const qint32 _dex;
    const qint32 _spd;
    const qint32 _lck;
    const qint32 _def;
    const qint32 _res;
    const qint32 _charm;
};
