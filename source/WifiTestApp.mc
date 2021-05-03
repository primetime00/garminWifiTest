using Toybox.Application;

class WifiTestApp extends Application.AudioContentProviderApp {

    function initialize() {
        AudioContentProviderApp.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Get a Media.ContentDelegate for use by the system to get and iterate through media on the device
    function getContentDelegate(arg) {
        return new WifiTestContentDelegate();
    }

    // Get a delegate that communicates sync status to the system for syncing media content to the device
    function getSyncDelegate() {
        return new WifiTestSyncDelegate();
    }

    // Get the initial view for configuring playback
    function getPlaybackConfigurationView() {
        return [ new WifiTestConfigurePlaybackView(), new WifiTestConfigurePlaybackDelegate() ];
    }

    // Get the initial view for configuring sync
    function getSyncConfigurationView() {
        return [ new WifiTestConfigureSyncView(), new WifiTestConfigureSyncDelegate() ];
    }

}
