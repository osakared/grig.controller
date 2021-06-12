package grig.controller;

interface Controller
{
    /**
     * Called when plugin instance is initialized
     */
    public function startup(host:Host):Void;

    /**
     * Called when plugin instance is shut down
     */
    public function shutdown():Void;
}