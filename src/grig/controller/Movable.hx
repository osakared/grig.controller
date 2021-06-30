package grig.controller;

interface Movable
{
    public function move(direction:Direction):Void;
    public function addCanMoveChangedCallback(callback:CanMoveChangedCallback):Void;
}