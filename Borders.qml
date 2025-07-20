import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.primitives

Item {
	id: root
	required property Item bar
	anchors.fill: parent

	Rectangle {
		id: rect

		anchors.fill: parent
		color: Config.palette.bg0
		visible: false
	}

	Item {
		id: mask

		anchors.fill: parent
		layer.enabled: true
		visible: false

		Rectangle {
			anchors.fill: parent
			anchors.margins: 12
			anchors.topMargin: root.bar.height
			radius: 22
		}
	}

	MultiEffect {
		anchors.fill: parent
		maskEnabled: true
		maskInverted: true
		maskSource: mask
		source: rect
		maskThresholdMin: 0.5
		maskSpreadAtMin: 1
	}
}
