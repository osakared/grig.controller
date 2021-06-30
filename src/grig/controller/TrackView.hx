package grig.controller;

interface TrackView
{
    /**
     * Gets number of tracks in the view
     * @return Int
     */
    public function getNumTracks():Int;

    /**
     * Selects given track
     * @param track 
     */
    public function selectTrack(track:Int):Void;

    /**
     * Toggles mute state of given track
     * @param track 
     */
    public function muteTrack(track:Int):Void;

    /**
     * Toggles solo state of given track
     * @param track 
     */
    public function soloTrack(track:Int):Void;

    /**
     * Stops given track
     * @param track 
     */
    public function stopTrack(track:Int):Void;

    /**
     * Toggles arm state of current track
     * @param track 
     */
    public function armTrack(track:Int):Void;

    /**
     * Listen in on which track is selected, assuming mutual exclusivity
     * @param selectTrackUpdateCallback 
     */
    public function addSelectTrackUpdateCallback(selectTrackUpdateCallback:SelectTrackUpdateCallback):Void;

    /**
     * Listens in on mute state of tracks in the view
     * @param callback 
     */
    public function addIsMutedCallback(callback:IndexedBoolCallback):Void;

    /**
     * Listens in on the solo state of tracks in the view
     * @param callback 
     */
    public function addIsSoloedCallback(callback:IndexedBoolCallback):Void;

    /**
     * Listens in on the armed state of tracks in the view
     * @param callback 
     */
    public function addIsArmedCallback(callback:IndexedBoolCallback):Void;

    /**
     * Listens in on the playback state of tracks in the view
     * @param callback 
     */
    public function addTrackStateUpdateCallback(callback:TrackStateUpdateCallback):Void;
}