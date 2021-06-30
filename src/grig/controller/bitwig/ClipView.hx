package grig.controller.bitwig;

import grig.controller.BoolCallback;

class ClipView implements grig.controller.ClipView
{
    private var trackBank:com.bitwig.extension.controller.api.TrackBank;
    private var hasSetupCallbacks:Bool = false;
    private var clips = new Array<Array<Clip>>();
    private var clipStateCallbacks = new Array<ClipStateUpdateCallback>();
    private var sceneStateCallbacks = new Array<SceneStateUpdateCallback>();
    private var canMoveCallbacks = new Array<CanMoveChangedCallback>();
    private var initializedCanMoveCallbacks = false;

    public function new(trackBank:com.bitwig.extension.controller.api.TrackBank)
    {
        this.trackBank = trackBank;

        for (i in 0...getNumTracks()) {
            var clipRow = new Array<Clip>();
            for (j in 0...getNumScenes()) {
                clipRow.push(new Clip());
            }
            clips.push(clipRow);
        }
    }

    public function getTrackView():TrackView
    {
        return new TrackView(trackBank);
    }

    public function move(direction:Direction):Void
    {
        switch direction {
            case Up: trackBank.sceneBank().scrollBackwards();
            case Down: trackBank.sceneBank().scrollForwards();
            case Left: trackBank.scrollBackwards();
            case Right: trackBank.scrollForwards();
        }
    }

    private function initializeCanMoveCallback():Void
    {
        if (initializedCanMoveCallbacks) return;
        initializedCanMoveCallbacks = true;

        trackBank.canScrollBackwards().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
            for (canMoveCallback in canMoveCallbacks) canMoveCallback(Left, value);
        }));

        trackBank.canScrollForwards().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
            for (canMoveCallback in canMoveCallbacks) canMoveCallback(Right, value);
        }));

        trackBank.sceneBank().canScrollBackwards().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
            for (canMoveCallback in canMoveCallbacks) canMoveCallback(Up, value);
        }));

        trackBank.sceneBank().canScrollForwards().addValueObserver(new BooleanChangedCallback((value:Bool) -> {
            for (canMoveCallback in canMoveCallbacks) canMoveCallback(Down, value);
        }));
    }

    public function addCanMoveChangedCallback(callback:CanMoveChangedCallback):Void
    {
        canMoveCallbacks.push(callback);
        initializeCanMoveCallback();
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

    private function onSceneStateChanged(scene:Int)
    {
        var allEmpty = true;
        var allPlaying = true;
        var allPlayQueued = true;
        var allStopQueued = true;
        for (i in 0...getNumTracks()) {
            var clip = clips[i][scene];
            switch clip.state {
                case Playing: allPlayQueued = allStopQueued = allEmpty = false;
                case Recording: allPlayQueued = allStopQueued = allEmpty = false; // let's count recording as playing
                case PlayingQueued: allPlaying = allStopQueued = allEmpty = false;
                case RecordingQueued: allPlaying = allStopQueued = allEmpty = false;
                case StopQueued: allPlaying = allPlayQueued = allEmpty = false;
                case Stopped: allPlaying = allPlayQueued = allStopQueued = allEmpty = false;
                case Empty: true;
            }
        }
        var sceneState:SceneState = if (allEmpty) SceneState.Stopped;
        else if (allPlaying) SceneState.Playing;
        else if (allPlayQueued) SceneState.PlayingQueued;
        else if (allStopQueued) SceneState.StopQueued;
        else SceneState.Stopped;

        for (sceneStateCallback in sceneStateCallbacks) sceneStateCallback(scene, sceneState);
    }

    private function onPlaybackStateChanged(track:Int, scene:Int, state:PlaybackState, isQueued:Bool)
    {
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
        var clip = clips[track][scene];
        clip.state = clipState;
        for (clipStateCallback in clipStateCallbacks) clipStateCallback(track, scene, clip.state);
        onSceneStateChanged(scene);

        // to get around a quirk in bitwig's api
        if (clipState == ClipState.PlayingQueued) {
            for (j in 0...getNumScenes()) {
                if (j == scene) continue;
                var otherPlaying = clips[track][j];
                if (otherPlaying.state == ClipState.Playing) {
                    otherPlaying.state = ClipState.StopQueued;
                    for (clipStateCallback in clipStateCallbacks) clipStateCallback(track, j, otherPlaying.state);
                    onSceneStateChanged(j);
                    break;
                }
            }
        }
    }

    private function setupCallbacks():Void
    {
        if (hasSetupCallbacks) return;
        hasSetupCallbacks = true;

        for (i in 0...getNumTracks()) {
            var track = trackBank.getItemAt(i);
            track.clipLauncherSlotBank().addPlaybackStateObserver(new PlaybackStateChangedCallback((idx:Int, state:PlaybackState, isQueued:Bool) -> {
                onPlaybackStateChanged(i, idx, state, isQueued);
            }));
            track.clipLauncherSlotBank().addHasContentObserver(new IndexedBooleanChangedCallback((idx:Int, value:Bool) -> {
                var clip = clips[i][idx];
                clip.hasContent = value;
                for (clipStateCallback in clipStateCallbacks) clipStateCallback(i, idx, clip.state);
            }));
        }
    }

    public function playClip(track:Int, scene:Int):Void
    {
        trackBank.getItemAt(track).clipLauncherSlotBank().getItemAt(scene).launch();
    }

    public function playScene(scene:Int):Void
    {
        trackBank.sceneBank().launchScene(scene);
    }

    public function addClipStateUpdateCallback(clipStateCallback:ClipStateUpdateCallback):Void
    {
        clipStateCallbacks.push(clipStateCallback);
        setupCallbacks();
    }

    public function addSceneUpdateCallback(sceneStateCallback:SceneStateUpdateCallback):Void
    {
        sceneStateCallbacks.push(sceneStateCallback);
        setupCallbacks();
    }
}