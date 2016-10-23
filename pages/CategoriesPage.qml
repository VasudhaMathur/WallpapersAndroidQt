import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: categoriesPage

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 0
            anchors {
                fill: parent
                rightMargin: 5
            }

            TopButton {
                source: Qt.resolvedUrl("../images/drawer.svg")
                onClicked: drawer.open()
            }

            Label {
                id: titleLabel
                text: qsTr("Categories")
                font.pixelSize: 20
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            TopButton {
                source: Qt.resolvedUrl("../images/search.svg")
                onClicked: {
                    stackView.push("qrc:/pages/SearchPage.qml")
                }
                width: 40
                height: 40
            }
        }
    }

    property bool clear_models: false

    function getCategoriesFinished(data)
    {
        if (data.success) {
            worker.sendMessage({'feed': 'categoriesPage', 'obj': data.categories, 'model': categoriesModel, 'clear_model': clear_models})
        }
    }

    function getCategories()
    {
        categoriesModel.clear()
        clear_models = true
        Scripts.get_categories();
    }

    Component.onCompleted: {
        getCategories()
    }

    WorkerScript {
        id: worker
        source: "../js/Worker.js"
        onMessage: {
            console.log(msg)
        }
    }

    BusyIndicator {
        id: busyIndicator
        visible: categoriesModel.count == 0
        anchors.fill: parent
    }

    ListModel {
        id: categoriesModel
    }

    ListView {
        id: categoriesView
        visible: categoriesModel.count > 0
        anchors.fill: parent

        currentIndex: -1
        model: categoriesModel
        delegate: ItemDelegate {
            width: parent.width
            text: qsTr(model.name)
            highlighted: ListView.isCurrentItem
            onClicked: {
                stackView.push("qrc:/pages/CategoryPage.qml", {"categoryId": model.id, "categoryName": model.name})
            }
        }
    }
}
