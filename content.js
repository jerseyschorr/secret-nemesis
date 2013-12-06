// This will run after user has clicked the detect controller button in the popup.
chrome.extension.onMessage.addListener(function(message, sender, sendResponse) {
    switch(message.type) {
        case "toggleController":
            var $body = $(document.body);
            $($body).addClass('secret-nemesis');
        break;
    }
});
