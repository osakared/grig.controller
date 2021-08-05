package grig.controller.bitwig;

import com.bitwig.extension.controller.api.NoteInput;
import grig.midi.MidiMessage;

class HostMidiOut implements grig.controller.HostMidiOut
{
    private var noteInput:NoteInput;

    public function new(noteInput:NoteInput)
    {
        this.noteInput = noteInput;
    }

    public function sendMessage(midiMessage:MidiMessage):Void
    {
        noteInput.sendRawMidiEvent(midiMessage.byte1, midiMessage.byte2, midiMessage.byte3);
    }

    public function setVelocityCurve(curve:Array<Int>):Void
    {
        var table = new java.NativeArray<java.lang.Integer>(128);
        for (i in 0...curve.length) {
            table[i] = curve[i];
        }
        noteInput.setVelocityTranslationTable(table);
    }
}