package grig.controller;

interface LaterallyMovable
{
    public function move(direction:LateralDirection):Void;
    public function cycle():Void;
    public function addCanMoveChangedCallback(callback:LateralCanMoveChangedCallback):Void;
}