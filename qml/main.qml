import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

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

    footer: TabBar {
        id: bar
        width: parent.width

        TabButton
        {
            text: "Characters"
        }

        TabButton
        {
            text: "Classes"
        }
    }
}
