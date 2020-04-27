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

        ListView
        {
            id: charsListView
            clip: true
            contentWidth: contentItem.childrenRect.width
            spacing: 5
            flickableDirection: Flickable.AutoFlickIfNeeded

            property bool filtered: false
            property var filteredItems: []

            header: RowLayout
            {
                spacing: 10

                TextField
                {
                    placeholderText: "Filter characters..."
                    onTextChanged:
                    {
                        charsListView.showFilteredItems(text);
                        forceActiveFocus()
                    }
                }

                ComboBox
                {
                    currentIndex: -1
                    model: {
                        var houses = new Set()
                        houses.add("")
                        characters.forEach(c => houses.add(c.house))
                        return Array.from(houses)
                    }
                    onCurrentIndexChanged: {
                        charsListView.showFilteredSections(textAt(currentIndex))
                    }
                }
            }

            model: characters

            delegate: CharacterBox { character: model.modelData }

            ScrollIndicator.vertical: ScrollIndicator { }
            ScrollIndicator.horizontal: ScrollIndicator { }

            section.property: "modelData.house"
            section.criteria: ViewSection.FullString
            section.delegate: Pane
            {
                width: parent.width
                Label
                {
                    anchors.centerIn: parent
                    text: section
                    font.bold: true
                    font.pointSize: 14
                }
            }

            function showFilteredItems(text)
            {
                charsListView.filteredItems.length = 0
                if(text !== "")
                {
                    filtered = true
                    model = characters.filter(c => c.name.toLowerCase().match(text.toLowerCase()) || c.house.toLowerCase().match(text.toLowerCase()))
                }
                else
                {
                    filtered = false
                    model = characters
                }
            }

            function showFilteredSections(text)
            {
                charsListView.filteredItems.length = 0
                if(text !== "")
                {
                    filtered = true
                    model = characters.filter(c => c.house.toLowerCase().match(text.toLowerCase()))
                }
                else
                {
                    filtered = false
                    model = characters
                }
            }
        }

        ListView
        {
            id: classListView
            clip: true
            contentWidth: contentItem.childrenRect.width
            spacing: 5
            flickableDirection: Flickable.AutoFlickIfNeeded

            property bool filtered: false
            property var filteredItems: []

            header: RowLayout
            {
                spacing: 10

                TextField
                {
                    placeholderText: "Filter classes..."
                    onTextChanged:
                    {
                        classListView.showFilteredItems(text);
                        forceActiveFocus()
                    }
                }

                ComboBox
                {
                    currentIndex: -1
                    model: {
                        var classTypes = new Set()
                        classTypes.add("")
                        characterClasses.forEach(c => classTypes.add(c.type))
                        return Array.from(classTypes)
                    }
                    onCurrentIndexChanged: {
                        classListView.showFilteredSections(textAt(currentIndex))
                    }
                }
            }

            model: filtered ? filteredItems : characterClasses

            delegate: ClassBox { feClass: model.modelData }

            ScrollIndicator.vertical: ScrollIndicator { }
            ScrollIndicator.horizontal: ScrollIndicator { }

            section.property: "modelData.type"
            section.criteria: ViewSection.FullString
            section.delegate: Pane
            {
                width: parent.width
                Label
                {
                    anchors.centerIn: parent
                    text: section
                    font.bold: true
                    font.pointSize: 14
                }
            }

            function showFilteredItems(text)
            {
                classListView.filteredItems.length = 0
                if(text !== "")
                {
                    filtered = true
                    model = characterClasses.filter(c => c.name.toLowerCase().match(text.toLowerCase()) || c.type.toLowerCase().match(text.toLowerCase()))
                }
                else
                {
                    filtered = false
                    model = characterClasses
                }
            }

            function showFilteredSections(text)
            {
                classListView.filteredItems.length = 0
                if(text !== "")
                {
                    filtered = true
                    model = characterClasses.filter(c => c.type.toLowerCase().match(text.toLowerCase()))
                }
                else
                {
                    filtered = false
                    model = characterClasses
                }
            }
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
