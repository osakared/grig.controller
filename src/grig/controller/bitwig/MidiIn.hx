package grig.controller.bitwig;

import grig.midi.MidiMessage;

class MidiIn implements grig.midi.MidiReceiver implements com.bitwig.extension.callback.ShortMidiDataReceivedCallback
{
    private var midiIn:com.bitwig.extension.controller.api.MidiIn;
    private var callback:(MidiMessage, Float)->Void = null;

    public function new(midiIn:com.bitwig.extension.controller.api.MidiIn)
    {
        this.midiIn = midiIn;
    }

    public function midiReceived(status:Int, data1:Int, data2:Int):Void
    {
        if (callback == null) return;
        callback(MidiMessage.ofArray([status, data1, data2]), 0.0);
    }

    public function setCallback(callback:(MidiMessage, Float)->Void):Void
    {
        if (this.callback == null) midiIn.setMidiCallback(this);
        this.callback = callback;
    }
}