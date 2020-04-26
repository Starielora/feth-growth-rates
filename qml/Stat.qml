import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ColumnLayout
{
    property alias name: statNameLabel.text
    property int characterGrowth: 0
    property int classGrowth: 0

    spacing: 0
    Label
    {
        id: statNameLabel
        opacity: 0.25
        Layout.fillHeight: true
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Label
    {
        text: characterGrowth + classGrowth
        Layout.fillHeight: true
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color:
        {
            if(classGrowth == 0) return "white" // TODO will break if material theme is changed.. should be theme-default
            else if(classGrowth > 0) return "green"
            else return "red"
        }

        MouseArea
        {
            enabled: classGrowth != 0
            anchors.fill: parent

            pressAndHoldInterval: 0

            onPressAndHold:
            {
                toolTip.visible = true
            }

            onReleased:
            {
                toolTip.visible = false
            }
        }

        ToolTip
        {
            id: toolTip
            text:
            {
                var sign = classGrowth > 0 ? " + " : " - "
                return characterGrowth + sign + Math.abs(classGrowth)
            }
        }
    }
}
