package fire.button;

import renoise.Midi.MidiOutputDevice;
import fire.button.ButtonType;

class Record implements Button
{
    public var color : Int;
    public var type : ButtonType;

    public function new(type :ButtonType) : Void
    {
        this.color = 0;
        this.type = type;
    }

    public function initialize(output :MidiOutputDevice) : Void
    {
        output.send(lua.Table.fromArray([0xB0, this.type, this.color]));
    }

    public function step(output :MidiOutputDevice) : Void
    {
        this.color++;
        output.send(lua.Table.fromArray([0xB0, this.type, this.color]));
    }
}