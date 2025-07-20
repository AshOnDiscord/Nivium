pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	Process {
		command: ["bun", `${Quickshell.env("HOME")}/.config/quickshell/services/scripts/Battery.ts`]
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
