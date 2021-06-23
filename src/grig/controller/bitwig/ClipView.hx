package grig.controller.bitwig;

import grig.controller.BoolCallback;

class ClipView implements grig.controller.ClipView
{
    private var trackBank:com.bitwig.extension.controller.api.TrackBank;

    public function new(trackBank:com.bitwig.extension.controller.api.TrackBank)
    {
        this.trackBank = trackBank;
    }

    public function moveLeft():Void
    {
        trackBank.scrollBackwards();
    }

    public function moveRight():Void
    {
        trackBank.scrollForwards();
    }

    public function moveUp():Void
    {
        trackBank.sceneBank().scrollBackwards();
    }

    public function moveDown():Void
    {
        trackBank.sceneBank().scrollForwards();
    }

    public function onCanMoveLeftChanged(callback:BoolCallback):Void
    {
        trackBank.canScrollBackwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveRightChanged(callback:BoolCallback):Void
    {
        trackBank.canScrollForwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveUpChanged(callback:BoolCallback):Void
    {
        trackBank.sceneBank().canScrollBackwards().addValueObserver(new BooleanChangedCallback(callback));
    }

    public function onCanMoveDownChanged(callback:BoolCallback):Void
    {
        trackBank.sceneBank().canScrollForwards().addValueObserver(new BooleanChangedCallback(callback));
    }
}