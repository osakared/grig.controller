package grig.controller.bitwig;

import com.bitwig.extension.controller.api.CursorDevice;
import tink.core.Outcome;

class DeviceView implements grig.controller.DeviceView
{
    private var device:CursorDevice;
    private var callbacks = new Array<LateralCanMoveChangedCallback>();
    private var initializedCallbacks = false;

    public function new(device:CursorDevice)
    {
        this.device = device;
        device.hasNext().markInterested();
        device.hasPrevious().markInterested();
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

    private function initializeCallbacks():Void
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        device.hasNext().addValueObserver(new BooleanChangedCallback((canMove:Bool) -> {
            for (callback in callbacks) {
                callback(Right, canMove);
            }
        }));
        device.hasPrevious().addValueObserver(new BooleanChangedCallback((canMove:Bool) -> {
            for (callback in callbacks) {
                callback(Left, canMove);
            }
        }));
    }

    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
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