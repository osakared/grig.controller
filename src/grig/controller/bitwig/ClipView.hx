package grig.controller.bitwig;

import grig.controller.BoolCallback;

class ClipView implements grig.controller.ClipView
{
    private var trackBank:com.bitwig.extension.controller.api.TrackBank;
    private var hasSetupCallbacks:Bool = false;
    private var callback:ClipStateUpdateCallback = null;

    public function new(trackBank:com.bitwig.extension.controller.api.TrackBank)
    {
        this.trackBank = trackBank;
    }

    public function moveLeft():Void
    {
        trackBank.scrollBackwards();
    }

    public function moveRight():Void
    {
        trackBank.scrollForwards();
    }

    public function moveUp():Void
    {
        trackBank.sceneBank().scrollBackwards();
    }

    public function moveDown():Void
    {
        trackBank.sceneBank().scrollForwards();
    }

    public function onCanMoveLeftChanged(callback:BoolCallback):Void
    {
        trackBank.canScrollBackwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveRightChanged(callback:BoolCallback):Void
    {
        trackBank.canScrollForwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveUpChanged(callback:BoolCallback):Void
    {
        trackBank.sceneBank().canScrollBackwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveDownChanged(callback:BoolCallback):Void
    {
        trackBank.sceneBank().canScrollForwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function stopAllClips():Void
    {
        trackBank.sceneBank().stop();
    }

    public function returnToArrangement():Void
    {
        trackBank.sceneBank().returnToArrangement();
    }

    public function getNumTracks():Int
    {
        return trackBank.getSizeOfBank();
    }

    public function getNumScenes():Int
    {
        return trackBank.sceneBank().getSizeOfBank();
    }

    private function setupCallbacks():Void
    {
        if (hasSetupCallbacks) return;
        if (callback == null) return;
        hasSetupCallbacks = true;

        for (i in 0...getNumTracks()) {
            var track = trackBank.getItemAt(i);
            track.clipLauncherSlotBank().addPlaybackStateObserver(new PlaybackStateChangedCallback((idx:Int, state:PlaybackState, isQueued:Bool) -> {
                var clipState:ClipState = if (isQueued) {
                    switch state {
                        case PlaybackState.Playing: ClipState.PlayingQueued;
                        case PlaybackState.Recording: ClipState.RecordingQueued;
                        case PlaybackState.Stopped: ClipState.StopQueued;
                    }
                } else {
                    switch state {
                        case PlaybackState.Playing: ClipState.Playing;
                        case PlaybackState.Recording: ClipState.Recording;
                        case PlaybackState.Stopped: ClipState.Stopped;
                    }
                }
                callback(i, idx, clipState);
            }));
            track.clipLauncherSlotBank().addHasContentObserver(new IndexedBooleanChangedCallback((idx:Int, value:Bool) -> {
                if (value) callback(i, idx, Stopped);
                else callback(i, idx, Empty);
            }));
        }
    }

    public function setClipStateUpdateCallback(callback:ClipStateUpdateCallback):Void
    {
        this.callback = callback;
        setupCallbacks();
    }
}