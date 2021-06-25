package grig.controller;

import tink.core.Promise;

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
    public function getTransport():Promise<Transport>;

    /**
     * Creates or gets a midi receiver
     * @param port hardware midi port
     * @return grig.midi.MidiReceiver
     */
    public function getMidiIn(port:Int):grig.midi.MidiReceiver;

    /**
     * Creates or gets a midi sender
     * @param port hardware midi port
     * @return grig.midi.MidiSender
     */
    public function getMidiOut(port:Int):grig.midi.MidiSender;

    /**
     * Queries whether the host supports a clip launcher
     * @return Bool
     */
    public function hasClipLauncher():Bool;

    /**
     * Creates a clip view
     * @param width number of tracks
     * @param height number of scenes
     * @return ClipView
     */
    public function createClipView(width:Int, height:Int):ClipView;

    // // Make these all return promises
    // public function createOscServer(port:Int):grig.osc.Server;
    // // Also should return a promise
    // public function createOscClient(host:String, ort:Int):grig.osc.Client;
}