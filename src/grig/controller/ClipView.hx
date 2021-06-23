package grig.controller;

interface ClipView
{
    public function moveLeft():Void;
    public function moveRight():Void;
    public function moveUp():Void;
    public function moveDown():Void;
    public function onCanMoveLeftChanged(callback:BoolCallback):Void;
    public function onCanMoveRightChanged(callback:BoolCallback):Void;
    public function onCanMoveUpChanged(callback:BoolCallback):Void;
    public function onCanMoveDownChanged(callback:BoolCallback):Void;
}