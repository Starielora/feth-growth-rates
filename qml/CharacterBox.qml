import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import feth 1.0

GroupBox
{
    property FETHCharacter character // TODO c++ Character can be confused with qml Character

    id: stats
    label: Label
    {
        font.bold: true
        text: character.name
    }

    ColumnLayout
    {
        RowLayout
        {
            Item
            {
                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
                SwipeView
                {
                    id: view
                    clip: true
                    anchors.fill: parent
                    Repeater
                    {
                        model: character.portraits
                        Loader {
                            active: SwipeView.isCurrentItem
                            sourceComponent: Image
                            {
                                asynchronous: true
                                mipmap: true
                                cache: false
                                fillMode: Image.PreserveAspectFit
                                source: "qrc:/data/portraits/" + modelData
                            }
                        }
                    }
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        view.currentIndex = view.currentIndex === view.count - 1 ? 0 : view.currentIndex + 1
                    }
                }
                PageIndicator {
                    count: view.count
                    currentIndex: view.currentIndex
                    anchors.bottom: view.bottom
                    anchors.horizontalCenter: view.horizontalCenter
                }
            }

            ColumnLayout
            {
                Layout.alignment: Qt.AlignTop
                ComboBox
                {
                    Layout.fillWidth: true
                    id: comboBox
                    model: characterClasses
                    textRole: "name"
                    currentIndex: -1
                }
                Button
                {
                    Layout.fillWidth: true
                    text: "Clear"
                    opacity: comboBox.currentIndex !== -1 ? 1 : 0
                    onClicked:
                    {
                        comboBox.currentIndex = -1
                    }
                }
            }
        }

        RowLayout
        {
            spacing: 5

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
        }
    }
}
