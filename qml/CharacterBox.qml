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

            CharacterPortrait
            {
                portraits: character.portraits

                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
            }

            CharacterClass
            {
                id: characterClass

                Layout.alignment: Qt.AlignTop

                classes: characterClasses
            }
        }

        CharacterStats
        {
            baseGrowthRates: character.baseGrowthRates
            characterClass: characterClass
        }
    }
}
