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
            currentIndex: -1
        }
        Stat
        {
            name: "HP"
            characterGrowth: character.baseGrowthRates.hp
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.hp : 0
        }
        Stat
        {
            name: "Str"
            characterGrowth: character.baseGrowthRates.str
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.str : 0
        }
        Stat
        {
            name: "Mag"
            characterGrowth: character.baseGrowthRates.mag
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.mag : 0
        }
        Stat
        {
            name: "Dex"
            characterGrowth: character.baseGrowthRates.dex
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.dex : 0
        }
        Stat
        {
            name: "Spd"
            characterGrowth: character.baseGrowthRates.spd
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.spd : 0
        }
        Stat
        {
            name: "Lck"
            characterGrowth: character.baseGrowthRates.lck
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.lck : 0
        }
        Stat
        {
            name: "Def"
            characterGrowth: character.baseGrowthRates.def
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.def : 0
        }
        Stat
        {
            name: "Res"
            characterGrowth: character.baseGrowthRates.res
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.res : 0
        }
        Stat
        {
            name: "Charm"
            characterGrowth: character.baseGrowthRates.charm
            classGrowth: comboBox.currentValue ? comboBox.currentValue.growthRates.charm : 0
        }
        Button
        {
            text: "Clear"
            visible: comboBox.currentIndex !== -1
            onClicked:
            {
                comboBox.currentIndex = -1
            }
        }
    }
}
