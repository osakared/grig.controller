package grig.controller.bitwig;

import com.bitwig.extension.controller.api.TrackBank;

class TrackView implements grig.controller.TrackView
{
    private var selectTrackUpdateCallbacks = new Array<SelectTrackUpdateCallback>();
    private var isMutedCallbacks = new Array<IndexedBoolCallback>();
    private var isSoloedCallbacks = new Array<IndexedBoolCallback>();
    private var trackBank:TrackBank;

    private var initiatedSelectTrackUpdateCallback = false;
    private var initiatedIsMutedCallbacks = false;
    private var initiatedIsSoloedCallbacks = false;

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

    public function setSelectTrackUpdateCallback(selectTrackUpdateCallback:SelectTrackUpdateCallback):Void
    {
        selectTrackUpdateCallbacks.push(selectTrackUpdateCallback);
        initiateSelectTrackUpdateCallback();
    }

    private function initiateIsMutedCallback():Void
    {
        if (initiatedIsMutedCallbacks) return;
        initiatedIsMutedCallbacks = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).mute().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                for (isMutedCallback in isMutedCallbacks) isMutedCallback(i, value);
            }));
        }
    }

    public function setIsMutedCallback(callback:IndexedBoolCallback):Void
    {
        isMutedCallbacks.push(callback);
        initiateIsMutedCallback();
    }

    private function initiateIsSoloedCallback():Void
    {
        if (initiatedIsSoloedCallbacks) return;
        initiatedIsSoloedCallbacks = true;

        for (i in 0...getNumTracks()) {
            trackBank.getItemAt(i).solo().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
                for (isSoloedCallback in isSoloedCallbacks) isSoloedCallback(i, value);
            }));
        }
    }

    public function setIsSoloedCallback(callback:IndexedBoolCallback):Void
    {
        isSoloedCallbacks.push(callback);
        initiateIsSoloedCallback();
    }
}