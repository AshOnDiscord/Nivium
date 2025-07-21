pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	property real percentage: 100
	property string icon: "resources/battery4.svg"
	property bool low: false
	property bool charging: false

	Process {
		command: ["bun", "--hot", `${Quickshell.env("HOME")}/.config/quickshell/services/scripts/Battery.ts`]
		running: true

		stdout: SplitParser {
			onRead: function (data) {
				const json = JSON.parse(data);
				root.percentage = Math.round((json.charge / json.capacity) * 100);
				root.icon = `resources/${json.icon}.svg`;
				root.low = json.low;
				root.charging = json.charging;
			}
		}
	}
}
