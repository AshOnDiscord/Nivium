import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

import qs.primitives

IconImage {
	required property string hoverText
	sourcePath: "resources/nixOsLogo.svg"

	implicitSize: 18
	color: Config.palette.fg2

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
				topMargin: 6
				bottomMargin: 6
				leftMargin: 8
				rightMargin: 8

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
