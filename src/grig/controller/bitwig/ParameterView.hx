package grig.controller.bitwig;

import com.bitwig.extension.controller.api.CursorRemoteControlsPage;

class ParameterView implements grig.controller.ParameterView
{
    private var remoteControls:CursorRemoteControlsPage;

    public function new(remoteControls:CursorRemoteControlsPage)
    {
        this.remoteControls = remoteControls;
        remoteControls.hasNext().markInterested();
    }

    public function setValue(idx:Int, value:Float):Void
    {
        remoteControls.getParameter(idx).set(value);
    }

    public function move(direction:LateralDirection):Void
    {
        switch direction {
            case Left: remoteControls.selectPrevious();
            case Right: remoteControls.selectNext();
        }
    }

    public function cycle():Void
    {
        remoteControls.selectNextPage(true);
    }

    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void
    {

    }
}