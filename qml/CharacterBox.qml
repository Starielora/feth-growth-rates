import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import feth 1.0

GroupBox
{
    property Character character // TODO c++ Character can be confused with qml Character

    id: stats
    label: Label
    {
        font.bold: true
        text: character.name
    }

    RowLayout
    {
        spacing: 10

        ComboBox
        {
            model: characterClasses
            textRole: "name"
            currentIndex: 7 // TODO index of base class
            onActivated:
            {
                character.characterClass = currentValue
            }
        }
        Stat
        {
            name: "HP"
            base: character.baseGrowthRates.hp
            modifier: character.characterClass.growthRates.hp
        }
        Stat
        {
            name: "Str"
            base: character.baseGrowthRates.str
            modifier: character.characterClass.growthRates.str
        }
        Stat
        {
            name: "Mag"
            base: character.baseGrowthRates.mag
            modifier: character.characterClass.growthRates.mag
        }
        Stat
        {
            name: "Dex"
            base: character.baseGrowthRates.dex
            modifier: character.characterClass.growthRates.dex
        }
        Stat
        {
            name: "Spd"
            base: character.baseGrowthRates.spd
            modifier: character.characterClass.growthRates.spd
        }
        Stat
        {
            name: "Lck"
            base: character.baseGrowthRates.lck
            modifier: character.characterClass.growthRates.lck
        }
        Stat
        {
            name: "Def"
            base: character.baseGrowthRates.def
            modifier: character.characterClass.growthRates.def
        }
        Stat
        {
            name: "Res"
            base: character.baseGrowthRates.res
            modifier: character.characterClass.growthRates.res
        }
        Stat
        {
            name: "Charm"
            base: character.baseGrowthRates.charm
            modifier: character.characterClass.growthRates.charm
        }
    }
}
