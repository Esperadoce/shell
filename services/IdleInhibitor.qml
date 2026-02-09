pragma Singleton

import Caelestia
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Singleton {
    id: root

    property alias enabled: props.enabled
    property alias ipcHandler: ipc
    readonly property alias enabledSince: props.enabledSince

    onEnabledChanged: {
        if (enabled) {
                props.enabledSince = new Date();
                Toaster.toast(qsTr("Keep awake enabled"), qsTr("Disabled lock screen and lock screen notifications"), "coffee");
            }
    }

    PersistentProperties {
        id: props

        property bool enabled
        property date enabledSince

        reloadableId: "idleInhibitor"
    }

    IdleInhibitor {
        enabled: props.enabled
        window: PanelWindow {
            implicitWidth: 0
            implicitHeight: 0
            color: "transparent"
            mask: Region {}
        }
    }

    IpcHandler {
        id: ipc
        target: "idleInhibitor"

        function isEnabled(): bool {
            return props.enabled;
        }

        function toggle(): void {
            props.enabled = !props.enabled;
        }

        function enable(): void {
            props.enabled = true;
        }

        function disable(): void {
            props.enabled = false;
        }
    }
}
