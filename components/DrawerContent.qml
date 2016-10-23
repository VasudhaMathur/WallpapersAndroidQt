import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Rectangle {
    width: parent.width
    height: parent.height

    Rectangle {
        id: drawerTop
        width: parent.width
        height: 150
        color: "#3f51b5"

        Image {
            id: appLogo
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Qt.resolvedUrl("../images/header2.jpg")
            cache: true
        }

        Label {
            z: 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 5
            text: "Wallpapers"
            color: "#ffffff"
            font.pixelSize: 14
            font.weight: Font.DemiBold
        }
    }

    ListView {
        id: listView
        currentIndex: 0
        anchors {
            top: drawerTop.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        delegate: ItemDelegate {
            width: parent.width
            text: model.title
            highlighted: ListView.isCurrentItem
            onClicked: {
                if (model.push) {
                    stackView.push(model.source)
                } else {
                    if (listView.currentIndex != index) {
                        listView.currentIndex = index
                        stackView.replace(model.source)
                    }
                }

                drawer.close()
            }
        }

        model: ListModel {
            ListElement { title: "Wallpapers"; source: "qrc:/pages/WallpapersPage.qml" }
            ListElement { title: "Categories"; source: "qrc:/pages/CategoriesPage.qml" }
            ListElement { title: "Collections"; source: "qrc:/pages/CollectionsPage.qml" }
            ListElement { title: "About"; source: "qrc:/pages/AboutPage.qml"; push: true }
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
