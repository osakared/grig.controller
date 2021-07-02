package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SendBank;

class SendView implements grig.controller.SendView
{
    private var sendBank:SendBank;

    public function new(sendBank:SendBank)
    {
        this.sendBank = sendBank;
        sendBank.canScrollForwards().markInterested();
    }

    public function move(direction:LateralDirection):Void
    {
        switch direction {
            case Left: sendBank.scrollBackwards();
            case Right: sendBank.scrollForwards();
        }
    }

    public function cycle():Void
    {
        if (sendBank.canScrollForwards().get()) sendBank.scrollForwards();
        else sendBank.scrollPosition().set(0);
    }

    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void
    {

    }

    public function setLevel(send:Int, level:Float):Void
    {
        sendBank.getItemAt(send).set(level);
    }
}