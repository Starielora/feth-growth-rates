import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ListView
{
    id: classListView
    clip: true
    contentWidth: contentItem.childrenRect.width
    spacing: 5
    flickableDirection: Flickable.AutoFlickIfNeeded

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
            model = characterClasses.filter(c => c.name.toLowerCase().match(text.toLowerCase()) || c.type.toLowerCase().match(text.toLowerCase()))
        }
        else
        {
            model = characterClasses
        }
    }

    function showFilteredSections(text)
    {
        classListView.filteredItems.length = 0
        if(text !== "")
        {
            model = characterClasses.filter(c => c.type.toLowerCase().match(text.toLowerCase()))
        }
        else
        {
            model = characterClasses
        }
    }
}
