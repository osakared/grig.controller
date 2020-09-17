package fire.button;

import renoise.Midi.MidiOutputDevice;
import fire.button.ButtonType;
import fire.LuaArray;

class Alt implements Button
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
        output.send(new LuaArray([0xB0, this.type, this.color]));
    }

    public function step(output :MidiOutputDevice) : Void
    {
        this.color++;
        output.send(new LuaArray([0xB0, this.type, this.color]));
    }
}