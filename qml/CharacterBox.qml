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
            id: comboBox
            model: characterClasses
            textRole: "name"
            currentIndex: 7 // TODO index of base class
        }
        Stat
        {
            name: "HP"
            base: character.baseGrowthRates.hp
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.hp : 0
        }
        Stat
        {
            name: "Str"
            base: character.baseGrowthRates.str
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.str : 0
        }
        Stat
        {
            name: "Mag"
            base: character.baseGrowthRates.mag
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.mag : 0
        }
        Stat
        {
            name: "Dex"
            base: character.baseGrowthRates.dex
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.dex : 0
        }
        Stat
        {
            name: "Spd"
            base: character.baseGrowthRates.spd
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.spd : 0
        }
        Stat
        {
            name: "Lck"
            base: character.baseGrowthRates.lck
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.lck : 0
        }
        Stat
        {
            name: "Def"
            base: character.baseGrowthRates.def
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.def : 0
        }
        Stat
        {
            name: "Res"
            base: character.baseGrowthRates.res
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.res : 0
        }
        Stat
        {
            name: "Charm"
            base: character.baseGrowthRates.charm
            modifier: comboBox.currentValue ? comboBox.currentValue.growthRates.charm : 0
        }
    }
}
