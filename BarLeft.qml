import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import qs.primitives

RowLayout {
	spacing: 8

	IconImage {
		implicitSize: 24
		source: Qt.resolvedUrl("resources/nixOsLogo.svg")
	}

	Item {
		implicitWidth: appInfo.implicitWidth
		implicitHeight: appInfo.implicitHeight
		ColumnLayout {
			id: appInfo
			spacing: 0
			Text {
				font.pointSize: 8
				color: Config.palette.fg2
				text: {
					const activeWindow = ToplevelManager.activeToplevel; // idk why the hyprland appId is null
					if (activeWindow?.activated) {
						return activeWindow.appId || "Unknown";
					}
					return `Workspace ${Hyprland.focusedWorkspace?.name ?? 0}`;
				}
			}

			Text {
				font.weight: Font.DemiBold
				font.pointSize: 10
				text: {
					const activeWindow = ToplevelManager.activeToplevel; // hyprland.title works but not .activated
					if (activeWindow?.activated) {
						return activeWindow.title || "Unknown";
					}
					return "Desktop";
				}
				elide: Text.ElideRight
				Layout.preferredWidth: 300
			}
		}

		Rectangle {
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: appInfo.left

			width: 300
			gradient: Gradient {
				orientation: Gradient.Horizontal
				GradientStop {
					position: 0.5
					color: "transparent"
				}
				GradientStop {
					position: 1.0
					color: Config.palette.bg0
				}
			}
		}
	}
}
