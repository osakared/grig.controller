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

    /**
     * Plays given scene
     * @param scene 
     */
    public function playScene(scene:Int):Void;

    /**
     * Sets listener for updates to clip states
     * @param callback 
     */
    public function setClipStateUpdateCallback(callback:ClipStateUpdateCallback):Void;
    
    /**
     * Sets listener for updates to scene states
     * @param callback 
     */
    public function setSceneUpdateCallback(callback:SceneStateUpdateCallback):Void;


}