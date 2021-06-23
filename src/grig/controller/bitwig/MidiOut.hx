package grig.controller.bitwig;

import grig.midi.MidiMessage;

class MidiOut implements grig.midi.MidiSender
{
    private var midiOut:com.bitwig.extension.controller.api.MidiOut;

    public function new(midiOut:com.bitwig.extension.controller.api.MidiOut)
    {
        this.midiOut = midiOut;
    }

    public function sendMessage(midiMessage:MidiMessage):Void
    {
        midiOut.sendMidi(midiMessage.byte1, midiMessage.byte2, midiMessage.byte3);
    }
}