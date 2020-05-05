import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ListView
{
    id: charsListView
    contentWidth: contentItem.childrenRect.width
    spacing: 10
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true

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
            model = characters.filter(c => c.name.toLowerCase().match(text.toLowerCase()) || c.house.toLowerCase().match(text.toLowerCase()))
        }
        else
        {
            model = characters
        }
    }

    function showFilteredSections(text)
    {
        charsListView.filteredItems.length = 0
        if(text !== "")
        {
            model = characters.filter(c => c.house.toLowerCase().match(text.toLowerCase()))
        }
        else
        {
            model = characters
        }
    }
}
