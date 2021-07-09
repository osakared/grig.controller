package grig.controller.bitwig;

import com.bitwig.extension.controller.api.NoteInput;
import grig.midi.MidiMessage;

class HostMidiOut implements grig.midi.MidiSender
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
}