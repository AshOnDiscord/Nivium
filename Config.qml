pragma Singleton

import Quickshell
import QtQuick

Singleton {
	property Palette palette: Palette {}
	property variant font: ({
			family: "Inter",
			monoFamily: "Adwaita Mono",
			pointSize: 10
		})

	component Palette: QtObject {
		property color bg0: "#050615"
		property color bg1: "#0A0F25"
		property color bg2: "#0D122C"
		property color bg3: "#121D3D"
		property color bg4: "#172653"
		property color fg0: "#FFFFFF"
		property color fg1: "#BFD0E5"
		property color fg2: "#86A2E3"
		property color fg3: "#3C5AB2"

		property color red: "#DB677C"
	}
}
