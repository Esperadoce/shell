import qs.components
import qs.services
import qs.config
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property var list
    readonly property string query: list.search.text.slice(`${Config.launcher.actionPrefix}askai `.length).trim()
    readonly property bool hasQuery: query.length > 0

    function runQuery(): void {
        if (!hasQuery) return;
        
        // Execute the AI query command
        // You'll need to configure the AI command in your config
        Quickshell.execDetached(["wl-copy", query]);
        root.list.visibilities.launcher = false;
    }

    function openInTerminal(): void {
        if (!hasQuery) return;
        
        // Open terminal with AI tool and the query
        Quickshell.execDetached(["app2unit", "--", ...Config.general.apps.terminal, "fish", "-C", `# AI tool with query: "${query}"`]);
        root.list.visibilities.launcher = false;
    }

    implicitHeight: Config.launcher.sizes.itemHeight

    anchors.left: parent?.left
    anchors.right: parent?.right

    StateLayer {
        radius: Appearance.rounding.normal

        function onClicked(): void {
            root.runQuery();
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Appearance.padding.larger

        spacing: Appearance.spacing.normal

        MaterialIcon {
            text: "smart_toy"
            font.pointSize: Appearance.font.size.extraLarge
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: Appearance.spacing.small

            StyledText {
                id: queryText
                text: hasQuery ? query : qsTr("Ask AI anything...")
                font.pointSize: Appearance.font.size.normal
                color: hasQuery ? Colours.palette.m3onSurface : Colours.palette.m3onSurfaceVariant
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            StyledText {
                id: hintText
                visible: hasQuery
                text: qsTr("Press Enter to copy query, click button to open in terminal")
                font.pointSize: Appearance.font.size.small
                color: Colours.palette.m3outline
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        StyledRect {
            visible: hasQuery
            color: Colours.palette.m3tertiary
            radius: Appearance.rounding.normal
            clip: true

            implicitWidth: (stateLayer.containsMouse ? label.implicitWidth + label.anchors.rightMargin : 0) + icon.implicitWidth + Appearance.padding.normal * 2
            implicitHeight: Math.max(label.implicitHeight, icon.implicitHeight) + Appearance.padding.small * 2

            Layout.alignment: Qt.AlignVCenter

            StateLayer {
                id: stateLayer

                color: Colours.palette.m3onTertiary

                function onClicked(): void {
                    root.openInTerminal();
                }
            }

            StyledText {
                id: label

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: icon.left
                anchors.rightMargin: Appearance.spacing.small

                text: qsTr("Open in terminal")
                color: Colours.palette.m3onTertiary
                font.pointSize: Appearance.font.size.normal

                opacity: stateLayer.containsMouse ? 1 : 0

                Behavior on opacity {
                    Anim {}
                }
            }

            MaterialIcon {
                id: icon

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Appearance.padding.normal

                text: "open_in_new"
                color: Colours.palette.m3onTertiary
                font.pointSize: Appearance.font.size.large
            }

            Behavior on implicitWidth {
                Anim {
                    easing.bezierCurve: Appearance.anim.curves.emphasized
                }
            }
        }
    }
}