import QtQuick 2.12
import QtQuick.Window 2.12

import QtWebEngine 1.7
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtWebChannel 1.0

//Window {
//    visible: true
//    width: 640
//    height: 480
//    title: qsTr("Hello World")


    QtObject {
        id: windowParent
        // Create the initial browsing windows and open the startup page.
        Component.onCompleted: {
            var firstWindow = windowComponent.createObject(windowParent);
            firstWindow.webView.url = "https://www.baidu.com"
            //firstWindow.webView.loadHtml('<input type="button" value="Click!" onclick="window.open(&quot;http://qt.io&quot;)">');
        }

        property Component windowComponent : Window {
            // Destroy on close to release the Window's QML resources.
            // Because it was created with a parent, it won't be garbage-collected.

            visible: true
            width: 640
            height: 480

            property WebEngineView webView: webView_
            WebEngineView {
                id: webView_
                anchors.fill: parent

                // Handle the signal. Dynamically create the window and
                // use its WebEngineView as the destination of our request.
                onNewViewRequested: function(request) {

                    var newWindow = windowComponent.createObject(windowParent);
                    request.openIn(newWindow.webView);
                }
            }
        }
    }
//}
