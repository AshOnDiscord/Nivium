import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.primitives

IconImage {
	required property string sourcePath
	property string hoverText: ""

	implicitSize: 18
	source: Qt.resolvedUrl(sourcePath)

	ToolTip {
		id: toolTip
		visible: hoverHandler.hovered
		text: hoverText

		contentItem: WrapperRectangle {
			color: "transparent"
			topMargin: 4
			WrapperRectangle {
				color: Config.palette.bg4
				radius: 1000
				topMargin: 4
				bottomMargin: 4
				leftMargin: 6
				rightMargin: 6

				Text {
					text: toolTip.text
					color: Config.palette.fg0
				}
			}
		}

		background: WrapperRectangle {
			color: "transparent"
		}
	}

	HoverHandler {
		id: hoverHandler
	}
}
