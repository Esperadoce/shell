import qs.components
import qs.components.misc
import qs.services
import qs.config
import qs.utils
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    anchors.fill: parent

    function getTempColor(temp: real): color {
        if (temp < 50) return Colours.palette.m3primary;
        if (temp < 70) return "#FFC107"; // yellow
        return "#FF5722"; // red
    }

    function displayTemp(temp: real): string {
        if (temp === 0) return "--°";
        return `${Math.ceil(temp)}°`;
    }

    Ref {
        service: SystemUsage
    }

    ColumnLayout {
        id: tempContent
        anchors.fill: parent
        anchors.margins: Appearance.padding.large
        spacing: Appearance.spacing.small

        TempItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon: "memory"
            tempValue: SystemUsage.cpuTemp
            label: "CPU"
            tempColor: getTempColor(SystemUsage.cpuTemp)
        }

        TempItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon: "developer_board"
            tempValue: 45 // Placeholder for MB temperature
            label: "MB"
            tempColor: getTempColor(45)
        }

        TempItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon: "videogame_asset"
            tempValue: SystemUsage.gpuTemp
            label: "GPU"
            tempColor: getTempColor(SystemUsage.gpuTemp)
        }

        TempItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon: "memory_alt"
            tempValue: 40 // Placeholder for RAM temperature
            label: "RAM"
            tempColor: getTempColor(40)
        }
    }

    component TempItem: Item {
        id: item

        required property string icon
        required property real tempValue
        required property string label
        required property color tempColor

        RowLayout {
            anchors.fill: parent
            spacing: Appearance.spacing.small

            MaterialIcon {
                Layout.alignment: Qt.AlignVCenter
                text: item.icon
                color: Colours.palette.m3onSurface
                font.pixelSize: Appearance.font.size.normal
            }

            StyledText {
                Layout.alignment: Qt.AlignVCenter
                text: item.label
                color: Colours.palette.m3onSurface
                font.pointSize: Appearance.font.size.small
            }

            Item {
                Layout.fillWidth: true
            }

            StyledText {
                Layout.alignment: Qt.AlignVCenter
                text: displayTemp(item.tempValue)
                color: item.tempColor
                font.pointSize: Appearance.font.size.normal
                font.weight: 600
            }
        }

        Behavior on tempValue {
            Anim {
                duration: Appearance.anim.durations.normal
            }
        }
    }
}
