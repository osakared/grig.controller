package fire.output.button;

import lua.Table;
import renoise.midi.Midi.MidiOutputDevice;
import fire.button.ButtonType;

abstract ButtonLight(ButtonType) from Int
{
    inline public function new(value :ButtonType) : Void
    {
        this = value;
    }

    public function send(output :MidiOutputDevice, value :Int) : Void
    {
        lightMsg[2] = this;
        lightMsg[3] = value;
        output.send(lightMsg);
    }

    private static var lightMsg :Table<Int, Int> = Table.create([0xB0]);
}