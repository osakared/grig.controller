package grig.controller;

@:autoBuild(grig.controller.Generator.build())
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

    /**
     * Called periodically for updating display of controller
     */
    public function flush():Void;
}