import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
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
			sourcePath: {
				const sink = Pipewire.defaultAudioSink;
				if (sink.audio.muted) return "resources/volumeOff.svg"
				const volume = +(sink.audio.volume * 100).toFixed(1)
				if (volume >= 50) return "resources/volume3.svg"
				if (volume >= 25) return "resources/volume2.svg"
				if (volume > 0) return "resources/volume1.svg"
				return "resources/volume0.svg"
			}
			hoverText: {
				const sink = Pipewire.defaultAudioSink;
				return `${sink.description} - ${(sink.audio.volume * 100).toFixed(1)}% (${sink.audio.muted ? "Muted" : "Unmuted"})`;
			}
		}
		PwObjectTracker {
			objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
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
