package grig.controller;

interface ClipView extends Movable
{
    /**
     * Gets associated TrackView
     * @return TrackView
     */
    public function getTrackView():TrackView;

    /**
     * Stops all playing clips
     */
    public function stopAllClips():Void;

    /**
     * Returns to timeline arrangement
     */
    public function returnToArrangement():Void;

    /**
     * Gets the "width" or number of tracks
     * @return Int
     */
    public function getNumTracks():Int;

    /**
     * Gets the "height" or number of scenes
     * @return Int
     */
    public function getNumScenes():Int;

    // It would be a nicer interface to be able to get clip objects and operate on them
    // However, that would make implementing this in some DAWs complicated and perhaps also mean
    // that api users are holding onto objects that are no longer valid.

    /**
     * Plays given clip
     * @param track 
     * @param scene 
     */
    public function playClip(track:Int, scene:Int):Void;

    /**
     * Stops given clip
     * @param track 
     * @param scene 
     */
    public function stopClip(track:Int, scene:Int):Void;

    /**
     * Selects given clip
     * @param track 
     * @param scene 
     */
    public function selectClip(track:Int, scene:Int):Void;

    /**
     * Records given clip
     * @param track 
     * @param scene 
     */
    public function recordClip(track:Int, scene:Int):Void;

    /**
     * Deletes given clip
     * @param track 
     * @param scene 
     */
    public function deleteClip(track:Int, scene:Int):Void;

    /**
     * Plays given scene
     * @param scene 
     */
    public function playScene(scene:Int):Void;

    /**
     * Sets listener for updates to clip states
     * @param callback 
     */
    public function addClipStateUpdateCallback(callback:ClipStateUpdateCallback):Void;
    
    /**
     * Sets listener for updates to scene states
     * @param callback 
     */
    public function addSceneUpdateCallback(callback:SceneStateUpdateCallback):Void;


}