import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "components"
import "js/scripts.js" as Scripts

ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "Wallpapers"

    // Landscape check
    property bool isLandscape: width > height

    // API
    property string auth_key: "414aeb60c70011bdfae360000d9bc353"
    property string api_url: 'https://wall.alphacoders.com/api2.0/get.php'

    property string current_version: "0.1"

    Settings {
        id: settings
    }

    StackView {
        id: stackView
        anchors.fill: parent

        Component.onCompleted: {
            stackView.replace("qrc:/pages/WallpapersPage.qml")
        }

        initialItem: Page {
            id: initialPage
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height

        ListView {
            id: listView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (listView.currentIndex != index) {
                        listView.currentIndex = index
                        stackView.replace(model.source)
                    }
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "Wallpapers"; source: "qrc:/pages/WallpapersPage.qml" }
                ListElement { title: "Categories"; source: "qrc:/pages/CategoriesPage.qml" }
                ListElement { title: "Collections"; source: "qrc:/pages/CollectionsPage.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}
