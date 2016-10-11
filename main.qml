import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

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

            header: ToolBar {
                Material.foreground: "white"

                RowLayout {
                    spacing: 20
                    anchors.fill: parent

                    Label {
                        id: titleLabel
                        text: "Wallpapers"
                        font.pixelSize: 20
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }
                }
            }

            Component.onCompleted: {
                Scripts.get_wallpapers(1);
            }

            ListModel {
                id: wallpapersModel
            }

            GridView {
                id: wallpapersView
                width: parent.width
                height: parent.height
                cellWidth: isLandscape ? (parent.width/4) : (parent.width/3)
                cellHeight: cellWidth*3/4

                model: wallpapersModel
                delegate: Item {
                    width: wallpapersView.cellWidth
                    height: wallpapersView.cellHeight
                    clip: true

                    Column {
                        anchors.fill: parent
                        Image {
                            width: parent.width
                            height: parent.height
                            sourceSize.width: parent.width
                            sourceSize.height: parent.height
                            clip: true
                            source: image
                            fillMode: Image.PreserveAspectCrop
                        }
                    }
                }
            }
        }
    }
}
