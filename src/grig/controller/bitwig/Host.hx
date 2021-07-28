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

    public function getMidiOut(port:Int):Promise<grig.midi.MidiSender>
    {
        if (midiOut == null) {
            try {
                var bitwigMidiOut = controllerHost.getMidiOutPort(port);
                midiOut = new MidiOut(bitwigMidiOut);
            } catch (e) {
                return Failure(new Error(InternalError, e.message));
            }
        }
        return Success(cast midiOut);
    }

    public function getHostMidiOut(name:String, port:Int, ?channel:Int, ?type:grig.midi.MessageType):Promise<grig.midi.MidiSender>
    {
        var typeString = if (type != null) {
            if (type & 0xf != 0) {
                // Probably not supported in Bitwig anyway
                return Failure(new Error(InternalError, 'Unsupported type: $type'));
            }
            StringTools.hex(type, 2).substr(0, 1);
        } else '?';
        var channelString = if (channel != null) {
            if (channel < 0 || channel > 15) {
                return Failure(new Error(InternalError, 'Unsupported channel: $channel'));
            }
            StringTools.hex(channel);
        } else '?';
        var matchString = typeString + channelString + '????';
        try {
            var noteOutput = controllerHost.getMidiInPort(port).createNoteInput(name, java.NativeArray.make(matchString));
            noteOutput.setShouldConsumeEvents(false);
            var hostMidiOut:grig.midi.MidiSender = new HostMidiOut(noteOutput);
            return Success(hostMidiOut);
        } catch (e) {
            return Failure(new Error(InternalError, e.message));
        }
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

    public function createDeviceView():Promise<grig.controller.DeviceView>
    {
        var cursorTrack = controllerHost.createCursorTrack(0, 0);
        var cursorDevice = cursorTrack.createCursorDevice();
        var deviceView:grig.controller.DeviceView = new DeviceView(cursorDevice);
        return Success(deviceView);
    }

    public function createControllerSettings():grig.controller.Settings
    {
        var settings:grig.controller.Settings = new Settings(controllerHost.getPreferences());
        return settings;
    }
}