import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.primitives

WrapperRectangle {
	color: Config.palette.bg2
	margin: 8
	radius: 1000

	RowLayout {
		Repeater {
			model: getWorkspaces()
			Rectangle {
				implicitWidth: 12
				implicitHeight: 12
				color: {
					if (modelData.active)
						return Config.palette.fg0;
					if (modelData.exists !== false)
						return Config.palette.fg2;
					return Config.palette.fg3;
				}
				radius: 12

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: {
						if (modelData.active)
							return;
						Hyprland.dispatch(`workspace ${modelData.id}`);
					}
				}
			}
		}
	}

	function getWorkspaces() {
		const minId = Math.max(Hyprland.workspaces.values.reduce((min, ws) => Math.min(min, ws.id), 1),1)
		const maxId = Hyprland.workspaces.values.reduce((max, ws) => Math.max(max, ws.id), 5);
		console.log(Hyprland.workspaces.values.map(ws => ws.id));
		const workspaces = [];
		const exisiting = Hyprland.workspaces.values;
		for (let i = minId; i <= maxId; i++) {
			const ws = exisiting.find(ws => ws.id === i);
			if (ws) {
				workspaces.push(ws);
			} else {
				workspaces.push({
					id: i,
					active: false,
					exists: false
				});
			}
		}
		return workspaces;
	}
}
