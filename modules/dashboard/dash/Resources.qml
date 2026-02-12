import qs.components
import qs.components.misc
import qs.services
import qs.config
import QtQuick

Row {
    id: root

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    padding: Appearance.padding.large
    spacing: Appearance.spacing.normal

    Ref {
        service: SystemUsage
    }

    Resource {
        icon: "memory"
        value: SystemUsage.cpuPerc
        colour: Colours.palette.m3primary
        labelValue: `${Math.round(SystemUsage.cpuPerc * 100)}`
    }

    Resource {
        icon: "memory_alt"
        value: SystemUsage.memPerc
        colour: Colours.palette.m3secondary
        labelValue: `${SystemUsage.formatKib(SystemUsage.memUsed).value.toFixed(1)}`
    }

        Resource {
        icon: "videogame_asset"
        value: SystemUsage.gpuPerc
        colour: Colours.palette.m3secondary
        labelValue: `${Math.round(SystemUsage.gpuPerc * 100)}`
    }

    Resource {
        icon: "hard_drive"
        value: SystemUsage.storagePerc
        colour: Colours.palette.m3tertiary
        labelValue: `${Math.round(SystemUsage.storagePerc * 100)}`
    }



    component Resource: Item {
        id: res

        required property string icon
        required property real value
        required property color colour
        required property string labelValue
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: Appearance.padding.large
        implicitWidth: icon.implicitWidth


        StyledRect {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.bottom: icon.top
            anchors.bottomMargin: Appearance.spacing.small

            implicitWidth: Config.dashboard.sizes.resourceProgessThickness

            color: Colours.layer(Colours.palette.m3surfaceContainerHigh, 2)
            radius: Appearance.rounding.full

            StyledRect {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                implicitHeight: res.value * parent.height

                color: res.colour
                radius: Appearance.rounding.full
            }

            StyledText {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                text : labelValue
            }
        }

        MaterialIcon {
            id: icon

            anchors.bottom: parent.bottom

            text: res.icon
            color: res.colour
        }

        Behavior on value {
            Anim {
                duration: Appearance.anim.durations.large
            }
        }
    }
}
