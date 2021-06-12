package grig.controller;

interface Host
{
    // Make these all return promises
    public function createOscServer(port:Int):grig.osc.Server;
    // Also should return a promise
    public function createOscClient(host:String, ort:Int):grig.osc.Client;
    // Dummy thing for now
    public function registerVolumeChangeCallback(callback:(volume:Float)->Void):Void;
}