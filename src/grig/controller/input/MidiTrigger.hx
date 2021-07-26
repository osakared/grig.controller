package grig.controller.input;

interface MidiTrigger
{
    /**
     * Handles if the note number matches
     * @param message midi message
     * @return Bool whether it was handled or not
     */
    public function handle(message:grig.midi.MidiMessage):Bool;
}