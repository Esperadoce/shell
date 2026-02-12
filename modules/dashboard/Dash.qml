import qs.components
import qs.components.filedialog
import qs.components.misc
import qs.services
import qs.config
import "dash"
import Quickshell
import QtQuick.Layouts

GridLayout {
    id: root

    required property PersistentProperties visibilities
    required property PersistentProperties state
    required property FileDialog facePicker

    Ref {
        service: SystemUsage
    }


    function displayTemp(temp: real): string {
        return `${Math.ceil(Config.services.useFahrenheit ? temp * 1.8 + 32 : temp)}°${Config.services.useFahrenheit ? "F" : "C"}`;
    }

    rowSpacing: Appearance.spacing.normal
    columnSpacing: Appearance.spacing.normal

    Rect {
        Layout.column: 2
        Layout.columnSpan: 3
        Layout.preferredWidth: user.implicitWidth
        Layout.preferredHeight: user.implicitHeight

        radius: Appearance.rounding.large

        User {
            id: user

            visibilities: root.visibilities
            state: root.state
            facePicker: root.facePicker
        }
    }

    Rect {
        Layout.row: 0
        Layout.columnSpan: 2
        Layout.preferredWidth: Config.dashboard.sizes.weatherWidth
        Layout.fillHeight: true

        radius: Appearance.rounding.large * 1.5

        Weather {}
    }

    Rect {
        Layout.row: 1
        Layout.preferredWidth: dateTime.implicitWidth
        Layout.fillHeight: true

        radius: Appearance.rounding.normal

        DateTime {
            id: dateTime
        }
    }

    Rect {
        Layout.row: 1
        Layout.column: 1
        Layout.columnSpan: 3
        Layout.fillWidth: true
        Layout.preferredHeight: calendar.implicitHeight

        radius: Appearance.rounding.large

        Calendar {
            id: calendar

            state: root.state
        }
    }

    Rect {
        Layout.row: 1
        Layout.column: 4

        Layout.preferredWidth: media.implicitWidth
        Layout.fillHeight: true

        radius: Appearance.rounding.large * 2

        Media {
            id: media
        }
    }

    Rect {
        Layout.row: 1
        Layout.column: 5
        Layout.preferredWidth: resources.implicitWidth
        Layout.fillHeight: true
        radius: Appearance.rounding.normal

        Resources {
            id: resources
        }
    }

    Rect {
        Layout.row: 0
        Layout.column: 5
        Layout.fillHeight: true
        Layout.fillWidth: true
        radius: Appearance.rounding.normal
        SystemTemperature {
            id: systemTemperature
        }
    }

    component Rect: StyledRect {
        color: Colours.tPalette.m3surfaceContainer
    }
}
