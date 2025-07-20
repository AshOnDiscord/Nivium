import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.primitives

Scope {

	Variants {
		model: Quickshell.screens

		PanelWindow {
			id: window
			property var modelData
			screen: modelData
			color: "transparent"

			anchors {
				top: true
				left: true
				right: true
				bottom: true
			}

			mask: Region {
				intersection: Intersection.Xor
				item: Rectangle {
					anchors.centerIn: parent
					x: 12
					y: bar.height
					width: window.width - 24
					height: window.height - 12 - bar.height
					radius: 8
				}
			}

			Item {
				anchors.fill: parent
				layer.enabled: true
				layer.effect: MultiEffect {
					shadowEnabled: true
					blurMax: 8
					shadowColor: Qt.alpha("#000", 0.75)
				}
				Borders {
					bar: bar
				}
			}

			Bar {
				id: bar
			}
		}
	}
}
