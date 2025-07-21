import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {
	id: root
	required property string sourcePath
	required property real implicitSize
	property string color: ""

	implicitWidth: implicitSize
	implicitHeight: implicitSize

	IconImage {
		implicitSize: root.implicitSize
		source: Qt.resolvedUrl(`${Quickshell.env("HOME")}/.config/quickshell/${sourcePath}`)

		layer.enabled: true
		layer.effect: MultiEffect {
			colorizationColor: root.color
			colorization: root.color === "" ? 0.0 : 1.0
		}
	}
}
