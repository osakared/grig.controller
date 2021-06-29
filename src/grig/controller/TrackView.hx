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
     * Mutes given track
     * @param track 
     */
    public function muteTrack(track:Int):Void;

    /**
     * Solos given track
     * @param track 
     */
    public function soloTrack(track:Int):Void;

    /**
     * Listen in on which track is selected, assuming mutual exclusivity
     * @param selectTrackUpdateCallback 
     */
    public function setSelectTrackUpdateCallback(selectTrackUpdateCallback:SelectTrackUpdateCallback):Void;

    /**
     * Listens in on mute state of tracks in the view
     * @param callback 
     */
    public function setIsMutedCallback(callback:IndexedBoolCallback):Void;

    /**
     * Listens in on the solo state of tracks in the view
     * @param callback 
     */
    public function setIsSoloedCallback(callback:IndexedBoolCallback):Void;
}