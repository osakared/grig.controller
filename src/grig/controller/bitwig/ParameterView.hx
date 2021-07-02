package grig.controller.bitwig;

import com.bitwig.extension.controller.api.CursorRemoteControlsPage;

class ParameterView implements grig.controller.ParameterView
{
    private var remoteControls:CursorRemoteControlsPage;

    public function new(remoteControls:CursorRemoteControlsPage)
    {
        this.remoteControls = remoteControls;
    }

    public function setValue(idx:Int, value:Float):Void
    {
        remoteControls.getParameter(idx).set(value);
    }

    public function move(direction:LateralDirection):Void
    {

    }

    public function cycle():Void
    {

    }

    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void
    {

    }
}