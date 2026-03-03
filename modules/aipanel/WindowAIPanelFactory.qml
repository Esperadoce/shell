pragma Singleton

import qs.components
import qs.services
import Quickshell // for PanelWindow
import QtQuick // for Text


Singleton {
  id:root

  function create(parent: Item, props: var): void {
    aiPanel.createObject(parent ?? dummy, props);
  }

  Component {
    id:aiPanel

    FloatingWindow{
      id:win
      title: qsTr("AI Chat")

      onVisibleChanged: {
          if (!visible)
              destroy();
      }

      AIPanel{
        id: aiPanel

        anchors.fill: parent
        screen: win.screen
        floating: true

        function close(): void {
            win.destroy();
        }
      }

      Behavior on color {
        CAnim {}
      }
    }
  }
}