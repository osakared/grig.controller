package fire.button;

import renoise.Midi.MidiOutputDevice;

interface Button
{
    var type :ButtonType;
    function initialize(output :MidiOutputDevice) : Void;
}