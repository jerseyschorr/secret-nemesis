// listening for an event / one-time requests
// coming from the popup

chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
    switch(request.type) {
        case "toggleController":
            toggleController(request.status);
        break;
    }
    return true;
});

var status = false;
var isGamepadConnected = function() {
    /*
    console.log('window.status: '+window.status);
    if(window.status) {
        window.status = false;
    } else {
        window.status = true;
    }
    console.log('window.status: '+window.status);
    console.log('status'+status);
    if(status === true) {
        status = false;
    } else {
        status = true;
    }
    console.log('status'+status);
    */
    return true;
};

// send a message to the content script
var toggleController = function() {
    if(isGamepadConnected()) {
        console.log('true', isGamepadConnected());
        chrome.tabs.getSelected(null, function(tab){
            // setting icon
            chrome.browserAction.setIcon({
                path: "images/38x38-on.png",
                tabId: tab.id
            });
            // setting a badge
            chrome.browserAction.setBadgeText({text: "1up"});
        });
    } else {
        console.log('false');
        chrome.tabs.getSelected(null, function(tab){
            // setting icon
            chrome.browserAction.setIcon({
                path: "images/38x38.png",
                tabId: tab.id
            });
            // setting a badge
            chrome.browserAction.setBadgeText({text: ""});
        });
    }
}

// tell content script to update icon
/*
chrome.runtime.onMessage.addListener(
    function(request, sender, sendResponse) {
        // read `newIconPath` from request and read `tab.id` from sender
        chrome.browserAction.setIcon({
            path: request.newIconPath,
            tabId: sender.tab.id
        });
    });
*/
