pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root
	property real screen: 100

	Process {
		command: ["bun", `${Quickshell.env("HOME")}/.config/quickshell/services/scripts/Brightness.ts`]
		running: true

		stdout: SplitParser {
			onRead: function (data) {
				root.screen = Math.round(parseFloat(data) * 100);
			}
		}
	}
}
