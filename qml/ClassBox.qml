import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import feth 1.0

GroupBox
{
    property FETHClass feClass // TODO c++ Character can be confused with qml Character

    id: stats
    label: Label
    {
        font.bold: true
        text: feClass.name
    }

    ColumnLayout
    {
        RowLayout
        {
            RowLayout
            {
                ComboBox
                {
                    id: comboBox
                    currentIndex: -1
                    model: characters
                    textRole: "name"
                }
                Button
                {
                    opacity: comboBox.currentIndex != -1 ? 1 : 0
                    onClicked: comboBox.currentIndex = -1
                    text: "Clear"
                }
            }
        }

        RowLayout
        {
            spacing: 5

            Stat
            {
                name: "HP"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.hp : 0
                classGrowth: feClass.growthRates.hp
            }
            Stat
            {
                name: "Str"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.str : 0
                classGrowth: feClass.growthRates.str
            }
            Stat
            {
                name: "Mag"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.mag : 0
                classGrowth: feClass.growthRates.mag
            }
            Stat
            {
                name: "Dex"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.dex : 0
                classGrowth: feClass.growthRates.dex
            }
            Stat
            {
                name: "Spd"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.spd : 0
                classGrowth: feClass.growthRates.spd
            }
            Stat
            {
                name: "Lck"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.lck : 0
                classGrowth: feClass.growthRates.lck
            }
            Stat
            {
                name: "Def"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.def : 0
                classGrowth: feClass.growthRates.def
            }
            Stat
            {
                name: "Res"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.res : 0
                classGrowth: feClass.growthRates.res
            }
            Stat
            {
                name: "Charm"
                characterGrowth: comboBox.currentValue ? comboBox.currentValue.baseGrowthRates.charm : 0
                classGrowth: feClass.growthRates.charm
            }
        }
    }
}
