package grig.controller.display;

import grig.controller.ClipView;

enum ShiftLauncherConfig
{
    Record;
    Delete;
    Stop;
    Select;
}

class ClipLauncher implements GridWidget
{
    public var midiDisplay(default, null):MidiDisplay;
    private var clipView:ClipView;
    private var shiftLauncherConfig:ShiftLauncherConfig = Record;

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

    public function setShiftLauncherConfig(shiftLauncherConfig:ShiftLauncherConfig)
    {
        this.shiftLauncherConfig = shiftLauncherConfig;
    }

    public function getTitle():String
    {
        return 'Clip Launcher';
    }

    public function pressButton(row:Int, column:Int, fnBtn:Bool):Void
    {
        if (fnBtn) {
            switch shiftLauncherConfig {
                case Record: clipView.recordClip(column, row);
                case Delete: clipView.deleteClip(column, row);
                case Stop: clipView.stopClip(column, row);
                case Select: clipView.selectClip(column, row);
            }
        }
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