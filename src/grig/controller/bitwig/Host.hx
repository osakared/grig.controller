package grig.controller.bitwig;

import com.bitwig.extension.controller.api.ControllerHost;
import tink.core.Error;
import tink.core.Promise;
import tink.core.Outcome;

class Host implements grig.controller.Host
{
    private var controllerHost:ControllerHost;
    private var transport:Transport;
    private var midiIn:MidiIn = null;
    private var midiOut:MidiOut = null;

    public function new(controllerHost:ControllerHost)
    {
        this.controllerHost = controllerHost;
        var bitwigTransport = controllerHost.createTransport();
        transport = new Transport(bitwigTransport);
    }

    public function showMessage(message:String):Void
    {
        controllerHost.showPopupNotification(message);
    }

    public function logMessage(message:String):Void
    {
        controllerHost.println(message);
    }

    public function getTransport():Promise<grig.controller.Transport>
    {
        return Success(cast transport);
    }

    public function getMidiIn(port:Int):Promise<grig.midi.MidiReceiver>
    {
        if (midiIn == null) {
            try {
                var bitwigMidiIn = controllerHost.getMidiInPort(port);
                midiIn = new MidiIn(bitwigMidiIn);
            } catch (e) {
                return Failure(new Error(InternalError, e.message));
            }
        }
        return Success(cast midiIn);
    }

    public function getMidiOut(port:Int):grig.midi.MidiSender
    {
        if (midiOut == null) {
            var bitwigMidiOut = controllerHost.getMidiOutPort(port);
            midiOut = new MidiOut(bitwigMidiOut);
        }
        return midiOut;
    }

    public function createClipView(width:Int, height:Int, ?sends:Int):Promise<grig.controller.ClipView>
    {
        if (sends == null) sends = 0;
        var trackBank = controllerHost.createTrackBank(width, sends, height);
        var clipView:grig.controller.ClipView = new ClipView(trackBank);
        return Success(clipView);
    }

    public function createTrackView(width:Int, ?height:Int, ?sends:Int):Promise<grig.controller.TrackView>
    {
        if (height == null) height = 0;
        if (sends == null) sends = 0;
        var trackBank = controllerHost.createTrackBank(width, sends, height);
        var trackView:grig.controller.TrackView = new TrackView(trackBank);
        return Success(trackView);
    }

    public function createParameterView(width:Int):Promise<grig.controller.ParameterView>
    {
        var cursorTrack = controllerHost.createCursorTrack(0, 0);
        var cursorDevice = cursorTrack.createCursorDevice();
        var remoteControls = cursorDevice.createCursorRemoteControlsPage(width);
        var parameterView:grig.controller.ParameterView = new ParameterView(remoteControls);
        return Success(parameterView);
    }
}