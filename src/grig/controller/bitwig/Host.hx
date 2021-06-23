package grig.controller.bitwig;

import com.bitwig.extension.controller.api.ControllerHost;

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

    public function getTransport():Transport
    {
        return transport;
    }

    public function getMidiIn(port:Int):grig.midi.MidiReceiver
    {
        if (midiIn == null) {
            var bitwigMidiIn = controllerHost.getMidiInPort(port);
            midiIn = new MidiIn(bitwigMidiIn);
        }
        return midiIn;
    }

    public function getMidiOut(port:Int):grig.midi.MidiSender
    {
        if (midiOut == null) {
            var bitwigMidiOut = controllerHost.getMidiOutPort(port);
            midiOut = new MidiOut(bitwigMidiOut);
        }
        return midiOut;
    }

    public function hasClipLauncher():Bool
    {
        return true;
    }

    public function createClipView(width:Int, height:Int):ClipView
    {
        var trackBank = controllerHost.createTrackBank(width, 0, height);
        return new ClipView(trackBank);
    }
}