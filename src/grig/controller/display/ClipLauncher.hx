package grig.controller.display;

import grig.controller.ClipView;

class ClipLauncher implements GridWidget
{
    public var midiDisplay(default, null):MidiDisplay;
    private var clipView:ClipView;

    public function new(midiDisplay:MidiDisplay, displayTable:MidiDisplayTable, clipView:ClipView)
    {
        this.midiDisplay = midiDisplay;
        this.clipView = clipView;

        clipView.addClipStateUpdateCallback((track:Int, scene:Int, state:grig.controller.ClipState) -> {
            var mode = switch state {
                case Playing: displayTable.playingState;
                case Recording: displayTable.recordingState;
                case Stopped: displayTable.stoppedState;
                case PlayingQueued: displayTable.playingQueuedState;
                case RecordingQueued: displayTable.recordingQueuedState;
                case StopQueued: displayTable.stopQueuedState;
                case Empty: displayTable.offState;
            }
            midiDisplay.set(scene, track, mode);
        });
    }

    public function getTitle():String
    {
        return 'Clip Launcher';
    }

    public function pressButton(row:Int, column:Int, fnBtn:Bool):Void
    {
        if (fnBtn) clipView.recordClip(column, row); // let's make this configurable!
        else clipView.playClip(column, row);
    }

    public function releaseButton(row:Int, column:Int, fbBtn:Bool):Void
    {
    }

    public function move(direction:grig.controller.Direction):Void
    {
        clipView.move(direction);
    }

    public function addCanMoveChangedCallback(callback:grig.controller.CanMoveChangedCallback):Void
    {
        clipView.addCanMoveChangedCallback(callback);
    }
}