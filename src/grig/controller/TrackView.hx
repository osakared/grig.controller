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
     * [Description]
     * @param selectTrackUpdateCallback 
     */
    public function setSelectTrackUpdateCallback(selectTrackUpdateCallback:SelectTrackUpdateCallback):Void;
}