package grig.controller.bitwig;

import com.bitwig.extension.controller.api.ControllerHost;

class Host implements grig.controller.Host
{
    private var controllerHost:ControllerHost;
    private var transport:Transport;
    private var midiIn:MidiIn = null;

    public function new(controllerHost_:ControllerHost)
    {
        controllerHost = controllerHost_;
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
}