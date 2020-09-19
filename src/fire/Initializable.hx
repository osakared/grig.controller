package fire;

import renoise.midi.Midi.MidiOutputDevice;

interface Initializable
{
    function initialize(output :MidiOutputDevice, display :Display) : Void;
}