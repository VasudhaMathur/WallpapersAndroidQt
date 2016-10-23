import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Particles 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "../components"

Page {
    id: aboutPage

    header: ToolBar {
        Material.foreground: "white"

        Column {
            RowLayout {
                spacing: 0
                anchors {
                    rightMargin: 5
                }

                TopButton {
                    source: Qt.resolvedUrl("../images/back.svg")
                    onClicked: stackView.pop()
                }

                Label {
                    id: titleLabel
                    text: qsTr("About")
                    font.pixelSize: 20
                    elide: Label.ElideRight
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
            }

            TabBar {
                Material.background: "transparent"
                Material.accent: "#ffffff"

                id: tabBar
                currentIndex: swipeView.currentIndex

                TabButton {
                    text: qsTr("About")
                }
                TabButton {
                    text: qsTr("Credits")
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Pane {
            width: swipeView.width
            height: swipeView.height

            Column {
                spacing: 20
                anchors {
                    fill: parent
                    margins: 20
                }

                Image {
                    source: "qrc:/images/Wallpapers.png"
                    width: 120
                    height: 120
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Column {
                    width: parent.width

                    Label {
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "<b>Wallpapers</b> " + current_version
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Column {
                    width: parent.width

                    Label {
                        text: "(C) 2016 Turan Mahmudov"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 12
                    }

                    Label {
                        text: "<a href=\"mailto://turan.mahmudov@gmail.com\">turan.mahmudov@gmail.com</a>"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        linkColor: "#FA6800"
                        font.pixelSize: 12
                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    Label {
                        text: qsTr("Released under the terms of the GNU GPL v3")
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 12
                    }
                }

                Label {
                    text: "Source code available on <a href=\"https://github.com/turanmahmudov/WallpapersAndroidQt\">Github</a>"
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    linkColor: "#FA6800"
                    font.pixelSize: 12
                    onLinkActivated: Qt.openUrlExternally(link)
                }

            }
        }

        Pane {
            width: swipeView.width
            height: swipeView.height

            Flickable {
                id: flickable
                anchors {
                    fill: parent
                }
                contentHeight: columnSuperior.height

                Column {
                   id: columnSuperior
                   width: parent.width

                   Item {
                       width: parent.width
                       height: sectionLabel.implicitHeight + 20

                       Label {
                           id: sectionLabel
                           text: qsTr("Creator")
                           font.weight: Font.DemiBold
                           font.pixelSize: 12
                           anchors.verticalCenter: parent.verticalCenter
                       }
                   }

                   HorizontalDivider { }

                   ItemDelegate {
                       width: parent.width
                       onClicked: {
                           Qt.openUrlExternally("mailto:turan.mahmudov@gmail.com")
                       }
                       Column {
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.right: parent.right
                           anchors.left: parent.left
                           Label {
                               width: parent.width
                               wrapMode: Text.WordWrap
                               text: "Turan Mahmudov"
                           }

                           Label {
                               font.pixelSize: 12
                               width: parent.width
                               wrapMode: Text.WordWrap
                               elide: Text.ElideRight
                               text: "turan.mahmudov@gmail.com"
                               color: "#333333"
                           }
                       }
                   }

                   Item {
                       width: parent.width
                       height: sectionLabel2.implicitHeight + 20

                       Label {
                           id: sectionLabel2
                           text: qsTr("Developers")
                           font.weight: Font.DemiBold
                           font.pixelSize: 12
                           anchors.verticalCenter: parent.verticalCenter
                       }
                   }

                   HorizontalDivider { }

                   ItemDelegate {
                       width: parent.width
                       onClicked: {
                           Qt.openUrlExternally("mailto:turan.mahmudov@gmail.com")
                       }
                       Column {
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.right: parent.right
                           anchors.left: parent.left
                           Label {
                               width: parent.width
                               wrapMode: Text.WordWrap
                               text: "Turan Mahmudov"
                           }

                           Label {
                               font.pixelSize: 12
                               width: parent.width
                               wrapMode: Text.WordWrap
                               elide: Text.ElideRight
                               text: "turan.mahmudov@gmail.com"
                               color: "#333333"
                           }
                       }
                   }

                   Item {
                       width: parent.width
                       height: sectionLabel2.implicitHeight + 20

                       Label {
                           id: sectionLabel3
                           text: qsTr("Logo")
                           font.weight: Font.DemiBold
                           font.pixelSize: 12
                           anchors.verticalCenter: parent.verticalCenter
                       }
                   }

                   HorizontalDivider { }

                   ItemDelegate {
                       width: parent.width
                       Column {
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.right: parent.right
                           anchors.left: parent.left
                           Label {
                               width: parent.width
                               wrapMode: Text.WordWrap
                               text: "Mkay Naut"
                           }
                       }
                   }
                }
            }
        }
    }
}
