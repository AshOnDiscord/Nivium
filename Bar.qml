import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.primitives

WrapperRectangle {
	id: barContent

	anchors.top: parent.top
	anchors.left: parent.left
	anchors.right: parent.right

	implicitHeight: 48
	leftMargin: 12
	rightMargin: 12
	color: "transparent"

	Item {

		BarLeft {
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
		}
		BarMiddle {
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
		}
		BarRight {
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
		}
	}
}
