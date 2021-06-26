package grig.controller.bitwig;

class PlaybackStateChangedCallback implements com.bitwig.extension.callback.ClipLauncherSlotBankPlaybackStateChangedCallback
{
    private var callback:PlaybackStateCallback;

    public function new(callback:PlaybackStateCallback)
    {
        this.callback = callback;
    }

    public function playbackStateChanged(idx:Int, state:PlaybackState, value:Bool):Void
    {
        callback(idx, state, value);
    }
}