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

    Settings {
        id: settings
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Page {
            id: homePage

            header: ToolBar {
                Material.foreground: "white"

                RowLayout {
                    spacing: 20
                    anchors.fill: parent

                    ToolButton {
                        contentItem: Image {
                            fillMode: Image.Pad
                            horizontalAlignment: Image.AlignHCenter
                            verticalAlignment: Image.AlignVCenter
                            source: "qrc:/images/drawer.png"
                        }
                        onClicked: {

                        }
                    }

                    Label {
                        id: titleLabel
                        text: "Wallpapers"
                        font.pixelSize: 20
                        elide: Label.ElideRight
                        verticalAlignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }
                }
            }

            property int page: 1
            property bool next_coming: true
            property bool more_available: true
            property bool clear_models: false

            function getWallpapersFinished(data)
            {
                if (data.success) {
                    if (data.wallpapers.length == 0) {
                        more_available = false
                    } else {
                        more_available = true
                    }

                    next_coming = true

                    worker.sendMessage({'feed': 'homePage', 'obj': data.wallpapers, 'model': wallpapersModel, 'clear_model': clear_models})

                    next_coming = false
                }
            }

            function getWallpapers(cpage)
            {
                clear_models = false
                if (!cpage || cpage === 1 || cpage === 0) {
                    wallpapersModel.clear()
                    page = 1
                    clear_models = true
                }
                Scripts.get_wallpapers(page);
            }

            Component.onCompleted: {
                getWallpapers()
            }

            WorkerScript {
                id: worker
                source: "js/Worker.js"
                onMessage: {
                    console.log(msg)
                }
            }

            BusyIndicator {
                id: busyIndicator
                visible: wallpapersModel.count == 0
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
                    if (atYEnd && !homePage.next_coming && homePage.more_available) {
                        homePage.page = homePage.page + 1
                        homePage.getWallpapers(homePage.page)
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
    }
}
