package grig.controller.bitwig;

import com.bitwig.extension.controller.api.CursorDevice;
import tink.core.Outcome;

class DeviceView implements grig.controller.DeviceView
{
    private var device:CursorDevice;

    public function new(device:CursorDevice)
    {
        this.device = device;
        device.hasNext().markInterested();
    }

    public function move(direction:LateralDirection):Void
    {
        switch direction {
            case Left: device.selectPrevious();
            case Right: device.selectNext();
        }
    }

    public function cycle():Void
    {
        if (device.hasNext().get()) device.selectNext();
        else device.selectFirst();
    }

    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void
    {

    }

    public function createParameterView(width:Int):Outcome<grig.controller.ParameterView, tink.core.Error>
    {
        var remoteControls = device.createCursorRemoteControlsPage(width);
        for (i in 0...width) {
            remoteControls.getParameter(i).setIndication(true);
        }
        var parameterView:grig.controller.ParameterView = new ParameterView(remoteControls);
        return Success(parameterView);
    }
}