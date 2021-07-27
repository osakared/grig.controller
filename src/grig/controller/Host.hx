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
     * @return Promise<Transport> which on success contains a Transport, failure if not available
     */
    public function getTransport():Promise<Transport>;

    /**
     * Creates or gets a midi receiver to talk to the controller
     * @param port hardware midi port
     * @return Promise<grig.midi.MidiReceiver> failure if unavailable or can't open port
     */
    public function getMidiIn(port:Int):Promise<grig.midi.MidiReceiver>;

    /**
     * Creates or gets a midi sender to talk to the controller
     * @param port hardware midi port
     * @return Promise<grig.midi.MidiSender>
     */
    public function getMidiOut(port:Int):Promise<grig.midi.MidiSender>;

    /**
     * Creates a midi sender to send to the host
     * @param name name to appear to user
     * @param port hardware midi port
     * @param channel restricts based on specified channel, if supplied
     * @param type restricts based on specified type, if supplied
     * @return Promise<grig.midi.MidiSender>
     */
    public function getHostMidiOut(name:String, port:Int, ?channel:Int, ?type:grig.midi.MessageType):Promise<grig.midi.MidiSender>;

    /**
     * Creates a clip view
     * @param width number of tracks
     * @param height number of scenes
     * @return Promise<ClipView>
     */
    public function createClipView(width:Int, height:Int, ?sends:Int):Promise<ClipView>;

    /**
     * Creates a track view
     * @param width number of tracks
     * @return Promise<TrackView>
     */
    public function createTrackView(width:Int, ?height:Int, ?sends:Int):Promise<TrackView>;

    /**
     * Creates a parameter view
     * @param width number of parameters
     * @return Promise<ParameterView>
     */
    public function createParameterView(width:Int):Promise<ParameterView>;
    
    /**
     * Gets application-wide settings. Hosts without settings capability will allow this and simply return default values every time and silently fail to 
     * save settings.
     * @return Settings
     */
    public function createControllerSettings():Settings;

    // // Make these all return promises
    // public function createOscServer(port:Int):grig.osc.Server;
    // // Also should return a promise
    // public function createOscClient(host:String, ort:Int):grig.osc.Client;
}