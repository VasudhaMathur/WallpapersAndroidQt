import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import DownloadManager 1.0

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

    // Dark & Light
    property bool isDarkTheme: false

    // API
    property string auth_key: "414aeb60c70011bdfae360000d9bc353"
    property string api_url: 'https://wall.alphacoders.com/api2.0/get.php'

    // App
    property string current_version: "0.1"

    // Res
    property int res_index: 0
    property string res_width: ""
    property string res_height: ""

    // Filters
    property int filter_by: 0

    // Signals
    signal filtered(int filterIndex)

    Material.theme: isDarkTheme ? Material.Dark : Material.Light

    DownloadManager {
        id: downloadManager
    }

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
        width: Math.min(window.width, window.height) / 4 * 3
        height: window.height

        DrawerContent { }
    }

    Popup {
        id: filtersPopup
        x: (window.width - width) / 2
        y: window.height / 6
        width: window.width
        height: filtersColumn.implicitHeight + topPadding + bottomPadding
        modal: true
        focus: true

        property int filter: filter_by

        contentItem: ColumnLayout {
            id: filtersColumn
            width: parent.width
            spacing: 20

            Label {
                text: qsTr("Filters")
                font.bold: true
            }

            Column {
                spacing: 0

                RadioButton {
                    text: qsTr("Featured")
                    checked: filter_by == 0
                    onCheckedChanged: {
                        if (checked) {
                            filtersPopup.filter = 0
                        }
                    }
                }
                RadioButton {
                    text: qsTr("Newest")
                    checked: filter_by == 1
                    onCheckedChanged: {
                        if (checked) {
                            filtersPopup.filter = 1
                        }
                    }
                }
                RadioButton {
                    text: qsTr("Highest Rated")
                    checked: filter_by == 2
                    onCheckedChanged: {
                        if (checked) {
                            filtersPopup.filter = 2
                        }
                    }
                }
                RadioButton {
                    text: qsTr("By Views")
                    checked: filter_by == 3
                    onCheckedChanged: {
                        if (checked) {
                            filtersPopup.filter = 3
                        }
                    }
                }
                RadioButton {
                    text: qsTr("By Favorites")
                    checked: filter_by == 4
                    onCheckedChanged: {
                        if (checked) {
                            filtersPopup.filter = 4
                        }
                    }
                }
            }

            Row {
                spacing: 20

                Button {
                    id: okButton
                    text: qsTr("Ok")
                    onClicked: {
                        filter_by = filtersPopup.filter
                        window.filtered(filter_by)
                        filtersPopup.close()
                    }

                    Material.foreground: Material.primary
                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true
                }

                Button {
                    id: cancelButton
                    text: qsTr("Cancel")
                    onClicked: {
                        filtersPopup.close()
                    }

                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true
                }
            }
        }
    }

    Connections{
        target: downloadManager
        onProgressValueChanged: {
            console.log(downloadManager.progressValue)
        }
    }
}
