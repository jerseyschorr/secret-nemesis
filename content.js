/*
var changeIcon = function(path) {
    alert('path: ' +path);
    chrome.runtime.sendMessage({ "newIconPath" : path });
};
*/

chrome.extension.onMessage.addListener(function(message, sender, sendResponse) {
    switch(message.type) {
        case "toggleController":
            alert('hi');
            //changeIcon(message.path);
        break;
    }
});
