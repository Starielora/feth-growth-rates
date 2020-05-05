import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import QtQuick.Controls.Material 2.12

import feth 1.0

ApplicationWindow
{
    id: window
    width: 360
    height: 520
    visible: true
    title: "Fire Emblem: Three Houses Growth Rates"

    SwipeView
    {
        anchors.fill: parent
        interactive: false
        currentIndex: bar.currentIndex

        CharactersListView
        {
            model: characters
        }

        ClassesListView
        {
            model: characterClasses
        }
    }

    footer: RowLayout
    {
        width: parent.width
        TabBar
        {
            id: bar
            Layout.fillWidth: true

            TabButton
            {
                text: "Characters"
            }

            TabButton
            {
                text: "Classes"
            }
        }

        ToolButton
        {
            text: qsTr("⋮")
            onClicked: settingsDialog.open()
        }
    }

    Dialog
    {
        id: settingsDialog
        modal: true
        anchors.centerIn: parent

        GroupBox
        {
            title: "Settings"
            anchors.fill: parent

            ColumnLayout
            {
                RowLayout
                {
                    Label
                    {
                        text: "Theme"
                    }
                    ComboBox
                    {
                        model: ["Dark", "Light"]
                        onCurrentIndexChanged:
                        {
                            const theme = valueAt(currentIndex)
                            if(theme === "Dark")
                                window.Material.theme = Material.Dark
                            else if(theme === "Light")
                                window.Material.theme = Material.Light
                            else
                                console.error("Unknown theme:" + theme)
                        }
                    }
                }
            }
        }
    }
}
