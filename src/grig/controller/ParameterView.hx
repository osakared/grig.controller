package grig.controller;

interface ParameterView extends LaterallyMovable
{
    public function setValue(idx:Int, value:Float):Void;
    public function incrementValue(idx:Int, increment:Float):Void;
}