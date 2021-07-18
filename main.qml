import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    width: 1000; height: 700
    visible: true
    title: qsTr('Analog Clock')

    Item {
        id: container

        anchors.fill: parent

        Image {
            id: background

            source: 'image/background.png'
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }
    }

    ShaderEffectSource {
        id: shader

        width: 320; height: 320
        sourceItem: container
        sourceRect: Qt.rect(x, y, width, height)
        anchors.centerIn: container
    }

    MaskedBlur {
        id: blur

        source: shader
        radius: 35
        samples: 30
        maskSource: mask
        anchors.fill: shader
    }

    Rectangle {
        id: mask

        width: 320; height: 320
        radius: 160
        visible: false
    }

    Rectangle {
        id: clock

        width: 320; height: 320
        radius: 160
        color: Qt.rgba(1, 1, 1, 0.06)
        border.color: Qt.rgba(1, 1, 1, 0.1)
        border.width: 2
        anchors.centerIn: parent

        Image {
            id: clockTemplate

            source: 'image/clock template.svg'
            sourceSize: Qt.size(320, 320)
            opacity: 0.6
            anchors.centerIn: parent
        }

        Rectangle {
            id: secondHand

            width: 3; height: 90
            radius: 5
            color: Qt.rgba(1, 1, 1, 0.2)
            transformOrigin: Item.Bottom
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 160 }
        }

        Rectangle {
            id: minuteHand

            width: 5; height: 80
            radius: 5
            color: Qt.rgba(1, 1, 1, 0.2)
            transformOrigin: Item.Bottom
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 160 }
        }

        Rectangle {
            id: hourHand

            width: 10; height: 60
            radius: 5
            color: Qt.rgba(1, 1, 1, 0.2)
            transformOrigin: Item.Bottom
            anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 160 }
        }
    }

    Timer {
        id: timer

        interval: 1000
        repeat: true
        triggeredOnStart: true
        running: true
        onTriggered: {
            let date = new Date();

            let second = date.getSeconds();
            let minute = date.getMinutes();
            let hour = date.getHours();

            hourHand.rotation = (hour * 30) + (minute / 2);
            minuteHand.rotation = (minute * 6) + (second / 10);
            secondHand.rotation = second * 6;
        }
    }
}
