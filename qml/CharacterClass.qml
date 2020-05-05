import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ColumnLayout
{
    property alias classes: comboBox.model
    property alias currentClass: comboBox.currentValue

    ComboBox
    {
        Layout.fillWidth: true
        id: comboBox
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
