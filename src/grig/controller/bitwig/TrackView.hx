package grig.controller.bitwig;

import com.bitwig.extension.controller.api.TrackBank;

class TrackView implements grig.controller.TrackView
{
    private var selectTrackUpdateCallbacks = new Array<SelectTrackUpdateCallback>();
    private var isMutedCallbacks = new Array<IndexedBoolCallback>();
    private var isSoloedCallbacks = new Array<IndexedBoolCallback>();
    private var isArmedCallbacks = new Array<IndexedBoolCallback>();
    private var trackStateUpdateCallbacks = new Array<TrackStateUpdateCallback>();

    private var trackBank:TrackBank;

    private var initiatedSelectTrackUpdateCallback = false;
    private var initiatedIsMutedCallback = false;
    private var initiatedIsSoloedCallback = false;
    private var initiatedIsArmedCallback = false;
    private var initiatedTrackStateUpdateCallback = false;

    public function new(trackBank:TrackBank)
    {
        this.trackBank = trackBank;
    }

    public function getNumTracks():Int
    {
        return trackBank.getSizeOfBank();
    }

    public function selectTrack(track:Int):Void
    {
        trackBank.getItemAt(track).selectInMixer();
    }

    public function muteTrack(track:Int):Void
    {
        trackBank.getItemAt(track).mute().toggle();
    }

    public function soloTrack(track:Int):Void
    {
        trackBank.getItemAt(track).solo().toggle();
    }

    public function armTrack(track:Int):Void
    {
        trackBank.getItemAt(track).arm().toggle();
    }

    public function stopTrack(track:Int):Void
    {
        trackBank.getItemAt(track).stop();
    }

    private function initiateSelectTrackUpdateCallback():Void
    {
        if (initiatedSelectTrackUpdateCallback) return;
        initiatedSelectTrackUpdateCallback = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).addIsSelectedInMixerObserver(new BooleanChangedCallback((value:Bool) -> {
                if (!value) return;
                for (selectTrackUpdateCallback in selectTrackUpdateCallbacks) {
                    selectTrackUpdateCallback(i);
                }
            }));
        }
    }

    public function addSelectTrackUpdateCallback(selectTrackUpdateCallback:SelectTrackUpdateCallback):Void
    {
        selectTrackUpdateCallbacks.push(selectTrackUpdateCallback);
        initiateSelectTrackUpdateCallback();
    }

    private function initiateIsMutedCallback():Void
    {
        if (initiatedIsMutedCallback) return;
        initiatedIsMutedCallback = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).mute().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                for (isMutedCallback in isMutedCallbacks) isMutedCallback(i, value);
            }));
        }
    }

    public function addIsMutedCallback(callback:IndexedBoolCallback):Void
    {
        isMutedCallbacks.push(callback);
        initiateIsMutedCallback();
    }

    private function initiateIsSoloedCallback():Void
    {
        if (initiatedIsSoloedCallback) return;
        initiatedIsSoloedCallback = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).solo().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                for (isSoloedCallback in isSoloedCallbacks) isSoloedCallback(i, value);
            }));
        }
    }

    public function addIsSoloedCallback(callback:IndexedBoolCallback):Void
    {
        isSoloedCallbacks.push(callback);
        initiateIsSoloedCallback();
    }

    private function initiateIsArmedCallback():Void
    {
        if (initiatedIsArmedCallback) return;
        initiatedIsArmedCallback = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).arm().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                for (isArmedCallback in isArmedCallbacks) isArmedCallback(i, value);
            }));
        }
    }

    public function addIsArmedCallback(callback:IndexedBoolCallback):Void
    {
        isArmedCallbacks.push(callback);
        initiateIsArmedCallback();
    }

    private function initiateTrackStateUpdateCallback():Void
    {
        if (initiatedTrackStateUpdateCallback) return;
        initiatedTrackStateUpdateCallback = true;

        for (i in 0...getNumTracks()) {
            var track = trackBank.getItemAt(i);
            track.isStopped().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                var state = if (value) TrackState.Stopped else TrackState.Playing;
                for (trackStateUpdateCallback in trackStateUpdateCallbacks) trackStateUpdateCallback(i, state);
            }));
            track.isQueuedForStop().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                if (!value) return;
                for (trackStateUpdateCallback in trackStateUpdateCallbacks) trackStateUpdateCallback(i, TrackState.StopQueued);
            }));
        }
    }

    public function addTrackStateUpdateCallback(callback:TrackStateUpdateCallback):Void
    {
        trackStateUpdateCallbacks.push(callback);
        initiateTrackStateUpdateCallback();
    }
}