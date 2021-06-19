package grig.controller;

interface Host
{
    /**
     * Shows message to end user
     * @param message message to display
     */
    public function showMessage(message:String):Void;

    /**
     * Show message on console
     * @param message message to log
     */
    public function logMessage(message:String):Void;
    
    /**
     * Creates or gets the transport for the active project
     */
    public function getTransport():Transport;

    /**
     * Gets or receives a midi receiver
     */
    public function getMidiIn(port:Int):grig.midi.MidiReceiver;

    /**
     * Queries whether the host supports a clip launcher
     * @return Bool
     */
    // public function hasClipLauncher():Bool;

    // // Make these all return promises
    // public function createOscServer(port:Int):grig.osc.Server;
    // // Also should return a promise
    // public function createOscClient(host:String, ort:Int):grig.osc.Client;
}