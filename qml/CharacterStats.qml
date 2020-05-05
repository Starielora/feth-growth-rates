import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import feth 1.0

RowLayout
{
    property FETHGrowthRates baseGrowthRates
    property CharacterClass characterClass

    spacing: 5

    Stat
    {
        name: "HP"
        characterGrowth: baseGrowthRates.hp
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.hp : 0
    }
    Stat
    {
        name: "Str"
        characterGrowth: baseGrowthRates.str
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.str : 0
    }
    Stat
    {
        name: "Mag"
        characterGrowth: baseGrowthRates.mag
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.mag : 0
    }
    Stat
    {
        name: "Dex"
        characterGrowth: baseGrowthRates.dex
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.dex : 0
    }
    Stat
    {
        name: "Spd"
        characterGrowth: baseGrowthRates.spd
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.spd : 0
    }
    Stat
    {
        name: "Lck"
        characterGrowth: baseGrowthRates.lck
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.lck : 0
    }
    Stat
    {
        name: "Def"
        characterGrowth: baseGrowthRates.def
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.def : 0
    }
    Stat
    {
        name: "Res"
        characterGrowth: baseGrowthRates.res
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.res : 0
    }
    Stat
    {
        name: "Charm"
        characterGrowth: baseGrowthRates.charm
        classGrowth: characterClass.currentClass ? characterClass.currentClass.growthRates.charm : 0
    }
}
