chrome.extension.onMessage.addListener(function(message, sender, sendResponse) {
    switch(message.type) {
        case "toggleController":
            console.log('hi');
            // chrome.runtime.sendMessage({ "hello" : 'hi' });
        break;
    }
});
