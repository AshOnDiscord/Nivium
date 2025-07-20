import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.primitives

RowLayout {
	spacing: 8
	layoutDirection: Qt.RightToLeft

	WrapperRectangle {
		color: powerButtonHover.hovered ? Config.palette.bg4 : Config.palette.bg0
		margin: 4
		radius: 1000
		IconImage {
			implicitSize: 18
			source: Qt.resolvedUrl("resources/power.svg")
		}

		HoverHandler {
			id: powerButtonHover
			cursorShape: Qt.PointingHandCursor
		}

		Behavior on color {
			ColorAnimation {
				duration: 125
				easing.type: Easing.InOutQuad
			}
		}
	}

	StatusArea {
		id: statusArea
	}

	WrapperRectangle {
		id: clockWrapper
		color: "transparent"
		radius: 1000

		property variant time: {
			const arr = Qt.formatDateTime(clock.date, "hh mm ss AP").split(" ");
			const h = arr[0];
			const m = arr[1];
			const s = arr[2];
			const ap = arr[3];
			return {
				h: h,
				m: m,
				s: s,
				ap: ap
			};
		}

		RowLayout {
			IconImage {
				Layout.alignment: Qt.AlignVCenter
				implicitSize: 18
				source: Qt.resolvedUrl("resources/calendarClock.svg")
			}
			RowLayout {
				Layout.alignment: Qt.AlignVCenter
				spacing: 0
				Text {
					font.family: Config.font.monoFamily
					text: clockWrapper.time.h
				}
				Text {
					font.family: Config.font.monoFamily
					color: Config.palette.fg1
					text: ":"
				}
				Text {
					font.family: Config.font.monoFamily
					text: clockWrapper.time.m
				}
				Text {
					font.family: Config.font.monoFamily
					color: Config.palette.fg1
					text: ":"
				}
				Text {
					font.family: Config.font.monoFamily
					text: clockWrapper.time.s
				}
				Text {
					font.family: Config.font.monoFamily
					text: " "
				}
				Text {
					font.family: Config.font.monoFamily
					font.pointSize: 10
					text: clockWrapper.time.ap
					color: Config.palette.fg2
				}
			}
		}

		SystemClock {
			id: clock
			precision: SystemClock.Seconds
		}
	}
}
