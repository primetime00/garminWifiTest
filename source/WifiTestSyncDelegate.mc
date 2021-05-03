using Toybox.Communications;
using Toybox.Media;
using Toybox.Application;
using Toybox.System;

class WifiTestSyncDelegate extends Media.SyncDelegate {
  			   
	var urls = ["https://github.com/primetime00/garminWifiTest/raw/main/audio/test.mp3"];
    			   
    var index = 0;

    function initialize() {
        SyncDelegate.initialize();
    }

    // Called when the system starts a sync of the app.
    // The app should begin to download songs chosen in the configure
    // sync view .
    
    function onDone(code, data) {
    	if (code == 200) {
    		System.println("Download Complete " + index);
    		index++;
    		Media.notifySyncProgress(100*index);    		
    		if (index < urls.size()) {
    			syncItem();
    			return;
    		}
    		else {
    			System.println("Download FAILED!! " + code);
    			Media.notifySyncComplete(null);
    			return;
    		}    		
    	}
    	System.println("ALL DONE?");
    	Media.notifySyncComplete(null);
    }
    
    function syncItem() {
    	var url = urls[index];
    			    	
        var options = {:method => Communications.HTTP_REQUEST_METHOD_GET,
                       :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_AUDIO,
                       :mediaEncoding => Media.ENCODING_MP3};
        Communications.makeWebRequest(url, null, options, self.method(:onDone));    
    }
    
    function onStartSync() {
    	Media.resetContentCache();
    	index = 0;
    	syncItem();    	    	    	                       
    }

    // Called by the system to determine if the app needs to be synced.
    function isSyncNeeded() {
        return true;
    }

    // Called when the user chooses to cancel an active sync.
    function onStopSync() {
        Communications.cancelAllRequests();
        Media.notifySyncComplete(null);
    }
}
