import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: searchPage

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 0
            anchors {
                fill: parent
                rightMargin: 5
            }

            TopButton {
                source: Qt.resolvedUrl("../images/back.svg")
                onClicked: stackView.pop()
            }

            TextField {
                Material.accent: "#ff5722"
                Material.foreground: "#ffffff"
                Material.theme: Material.Dark

                id: searchQuery
                anchors.left: parent.left
                anchors.leftMargin: 53
                anchors.right: parent.right
                anchors.rightMargin: 5
                inputMethodHints: Qt.ImhNoPredictiveText
                placeholderText: qsTr("Search")
                onVisibleChanged: {
                    if (visible) {
                        forceActiveFocus()
                    }
                }
                onAccepted: {
                    term = searchQuery.text
                    searchWallpapers(1, term, true)
                }
            }
        }
    }

    property string term: ""
    property int page: 1
    property bool next_coming: true
    property bool more_available: true
    property bool clear_models: false
    property bool search_loading: false

    function getWallpapersFinished(data)
    {
        search_loading = false

        if (data.success) {
            if (data.wallpapers.length == 0) {
                more_available = false
            } else {
                more_available = true
            }

            next_coming = true

            worker.sendMessage({'feed': 'searchPage', 'obj': data.wallpapers, 'model': wallpapersModel, 'clear_model': clear_models})

            next_coming = false
        }
    }

    function searchWallpapers(cpage, term, clear)
    {
        if (!clear) {
            clear_models = false
        } else {
            search_loading = true
            clear_models = true
        }

        if (!cpage || cpage === 1 || cpage === 0) {
            wallpapersModel.clear()
            page = 1
            clear_models = true
        }
        Scripts.search_wallpapers(page, term);
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
        visible: wallpapersModel.count == 0 && search_loading == true
        anchors.fill: parent
    }

    ListModel {
        id: wallpapersModel
    }

    GridView {
        id: wallpapersView
        visible: wallpapersModel.count > 0
        anchors.fill: parent
        cellWidth: isLandscape ? (parent.width/4) : (parent.width/3)
        cellHeight: cellWidth*3/4

        onMovementEnded: {
            if (atYEnd && !searchPage.next_coming && searchPage.more_available) {
                searchPage.page = searchPage.page + 1
                searchPage.searchWallpapers(searchPage.page, term, false)
            }
        }

        model: wallpapersModel
        delegate: Item {
            width: wallpapersView.cellWidth
            height: wallpapersView.cellHeight
            clip: true

            Column {
                anchors.fill: parent
                anchors.margins: 2
                Image {
                    width: parent.width
                    height: parent.height
                    sourceSize.width: width
                    sourceSize.height: height
                    clip: true
                    source: url_thumb
                    fillMode: Image.PreserveAspectCrop
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stackView.push("qrc:/pages/PhotoPage.qml", {"photoDetails": wallpapersModel.get(index)})
                }
            }
        }
    }
}
