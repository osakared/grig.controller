package grig.controller.bitwig;

import com.bitwig.extension.controller.api.CursorRemoteControlsPage;

class ParameterView implements grig.controller.ParameterView
{
    private var remoteControls:CursorRemoteControlsPage;
    private var callbacks = new Array<LateralCanMoveChangedCallback>();
    private var initializedCallbacks = false;

    public function new(remoteControls:CursorRemoteControlsPage)
    {
        this.remoteControls = remoteControls;
        remoteControls.hasNext().markInterested();
        remoteControls.hasPrevious().markInterested();
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

    private function initializeCallbacks():Void
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        remoteControls.hasNext().addValueObserver(new BooleanChangedCallback((canMove:Bool) -> {
            for (callback in callbacks) {
                callback(Right, canMove);
            }
        }));
        remoteControls.hasPrevious().addValueObserver(new BooleanChangedCallback((canMove:Bool) -> {
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
}