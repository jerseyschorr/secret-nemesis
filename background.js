// listening for an event / one-time requests
// coming from the popup

chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
    switch(request.type) {
        case "toggleController":
            toggleController();
        break;
    }
    return true;
});

var status = false;
var isGamepadConnected = function() {
    // Place gamepad detection code here.
    // Returns true for now.
    return true;
};

// send a message to the content script
var toggleController = function() {
    if(isGamepadConnected()) {
        chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
            chrome.tabs.sendMessage(tabs[0].id, {type: "toggleController"}, function(response) {
                console.log('done');
            });
            // setting icon
            chrome.browserAction.setIcon({
                path: "images/38x38-on.png",
                tabId: tabs[0].id
            });
            // setting a badge
            chrome.browserAction.setBadgeText({text: "1up"});
        });
    } else {
        console.log('false');
        chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
            // setting icon
            chrome.browserAction.setIcon({
                path: "images/38x38.png",
                tabId: tabs[0].id
            });
            // setting a badge
            chrome.browserAction.setBadgeText({text: ""});
        });
    }
}
