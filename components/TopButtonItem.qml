import QtQuick 2.6

Item {
    id: root_digit

    property alias color: colorizedImage.keyColorOut
    //    property alias keyColor: colorizedImage.keyColorIn
    property alias source: image.source
    property alias asynchronous: image.asynchronous

    width: image.implicitWidth
    height: image.implicitHeight

    Component.onCompleted: image.completed = true

    Image {
        id: image

        property bool completed: false

        visible: !colorizedImage.visible
        anchors.fill: parent
        sourceSize.width: root_digit.width
        source: ""
        cache: false
        asynchronous: true
        onImplicitWidthChanged: completed = false
    }

    ShaderEffect {
        id: colorizedImage

        property Image source: image
        property color keyColorOut: Qt.rgba(0.0, 0.0, 0.0, 0.0)
        property color keyColorIn: "#808080"
        property real threshold: 0.1

        // Whether or not a color has been set.
        visible: image.status == Image.Ready && keyColorOut != Qt.rgba(0.0, 0.0, 0.0, 0.0)
        anchors.fill: parent

        fragmentShader: "
               varying highp vec2 qt_TexCoord0;
               uniform sampler2D source;
               uniform highp vec4 keyColorOut;
               uniform highp vec4 keyColorIn;
               uniform lowp float threshold;
               uniform lowp float qt_Opacity;
               void main() {
                   lowp vec4 sourceColor = texture2D(source, qt_TexCoord0);
                   gl_FragColor = mix(keyColorOut * vec4(sourceColor.a), sourceColor, step(threshold, distance(sourceColor.rgb / sourceColor.a, keyColorIn.rgb))) * qt_Opacity;
               }"
    }

}
