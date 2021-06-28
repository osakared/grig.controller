package grig.controller.bitwig;

import com.bitwig.extension.controller.api.TrackBank;

class TrackView implements grig.controller.TrackView
{
    private var selectTrackUpdateCallbacks = new Array<SelectTrackUpdateCallback>();
    private var trackBank:TrackBank;

    private var initiatedSelectTrackUpdateCallback = false;

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
        this.selectTrackUpdateCallbacks.push(selectTrackUpdateCallback);
        initiateSelectTrackUpdateCallback();
    }
}