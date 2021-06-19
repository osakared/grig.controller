package grig.controller;

interface Transport
{
    public function play():Void;
    public function stop():Void;
    public function pause():Void;
    public function record():Void;
    public function playPause():Void;
}