package grig.controller.bitwig;

import grig.midi.MidiMessage;

class MidiIn implements grig.midi.MidiReceiver implements com.bitwig.extension.callback.ShortMidiDataReceivedCallback
{
    private var midiIn:com.bitwig.extension.controller.api.MidiIn;
    private var callback:(MidiMessage, Float)->Void = null;

    public function new(midiIn_:com.bitwig.extension.controller.api.MidiIn)
    {
        midiIn = midiIn_;
        midiIn.setMidiCallback(this);
    }

    public function midiReceived(status:Int, data1:Int, data2:Int):Void
    {
        if (callback == null) return;
        callback(MidiMessage.ofArray([status, data1, data2]), 0.0);
    }

    public function setCallback(callback_:(MidiMessage, Float)->Void):Void
    {
        callback = callback_;
    }
}