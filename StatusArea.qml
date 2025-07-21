import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.primitives

WrapperRectangle {
	color: Config.palette.bg2
	topMargin: 4
	bottomMargin: 4
	leftMargin: 6
	rightMargin: 6
	radius: 1000

	RowLayout {
		StatusAreaIcon {
			sourcePath: "resources/wifi4.svg"
			hoverText: "Wifi"
		}
		StatusAreaIcon {
			sourcePath: "resources/bluetoothConnected.svg"
			hoverText: "Bluetooth"
		}
		StatusAreaIcon {
			sourcePath: "resources/volume2.svg"
			hoverText: "Volume"
		}
		StatusAreaIcon {
			sourcePath: Brightness.screen > 50 ? "resources/brightnessHigh.svg" : "resources/brightnessLow.svg"
			hoverText: `${Brightness.screen}%`
		}
		StatusAreaIcon {
			sourcePath: `${Battery.icon}`
			hoverText: `${Battery.percentage}% - ${Battery.charging ? "Charging" : "Not Charging"}`
			color: {
				if (Battery.charging)
					return Config.palette.fg1;
				if (Battery.low)
					return Config.palette.red;
				return Config.palette.fg2;
			}
		}
	}
}
