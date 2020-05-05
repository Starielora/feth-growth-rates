import QtQuick 2.14
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Item
{
    property alias portraits: repeater.model

    SwipeView
    {
        id: view
        clip: true
        anchors.fill: parent
        Repeater
        {
            id: repeater
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

    PageIndicator
    {
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: view.bottom
        anchors.horizontalCenter: view.horizontalCenter
    }
}
