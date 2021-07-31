package grig.controller;

interface Setting<T>
{
    public function get():T;
    public function set(value:T):Void;
    public function addValueCallback(callback:(value:T)->Void):Void;
}