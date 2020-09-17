package fire;

import renoise.Midi.MidiOutputDevice;
import fire.Color;
import fire.LuaArray;

//54-117
class Grid
{
    public var color : Int;
    public var stepIndex : Int;

    public function new() : Void
    {
        this.color = 0;
        this.stepIndex = 0;
    }

    public function update(output :MidiOutputDevice) : Void
    {
    }

    public function initialize(output :MidiOutputDevice) : Void
    {
        colorRow(output, 0, new Color(0xFF110000));
        colorRow(output, 1, new Color(0xFF110000));
        colorRow(output, 2, new Color(0xFF110000));
        colorRow(output, 3, new Color(0xFF110000));
    }

    public function colorRow(output :MidiOutputDevice, row :Int, color :Color) : Void
    {
        var steps = 16;
        var byteLength = steps * 4;

        var msg = new LuaArray([0xF0, 0x47, 0x7F, 0x43, 0x65, 0x00, byteLength]);
        for(i in 0...steps) {
            var index = i + row * 16;
            msg.push(index);
            msg.push(color.red);
            msg.push(color.blue);
            msg.push(color.green);
        }
        msg.push(0xF7);
        output.send(msg);
    }

    public function step(output :MidiOutputDevice) : Void
    {
        this.color++;
        output.send(new LuaArray([0xB0, 0x54, this.color]));
    }
}