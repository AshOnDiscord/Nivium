//import Quickshell
//import Quickshell.Widgets
//import QtQuick
//import QtQuick.Layouts
//
//import qs.primitives
//
//WrapperRectangle {
//	id: barContent
//
//	anchors.top: parent.top
//	anchors.left: parent.left
//	anchors.right: parent.right
//
//	implicitHeight: 48
//	leftMargin: 12
//	rightMargin: 12
//	color: "transparent"
//
//	Item {
//
//		BarLeft {
//			anchors.verticalCenter: parent.verticalCenter
//			anchors.left: parent.left
//		}
//		BarMiddle {
//			anchors.verticalCenter: parent.verticalCenter
//			anchors.horizontalCenter: parent.horizontalCenter
//		}
//		BarRight {
//			anchors.verticalCenter: parent.verticalCenter
//			anchors.right: parent.right
//		}
//	}
//}

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.primitives

PanelWindow {
    id: bar
    color: Config.palette.bg0

    anchors {
        top: true
        left: true
        right: true
    }

    height: 48
    exclusiveZone: height   // reserves space so windows don't overlap

    // wlroots layer-shell properties
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "bar"

    WrapperRectangle {
        anchors.fill: parent
        color: "transparent"
        leftMargin: 12
        rightMargin: 12

        Item {
            anchors.fill: parent

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
}
