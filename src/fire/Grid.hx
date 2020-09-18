/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package fire;

import renoise.Midi.MidiOutputDevice;
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

    public function initialize(output :MidiOutputDevice, display :Display) : Void
    {
        colorRow(output, 0, 0);
        colorRow(output, 1, 0);
        colorRow(output, 2, 0);
        colorRow(output, 3, 0);
    }

    public function colorRow(output :MidiOutputDevice, row :Int, color :Int) : Void
    {
        var steps = 16;
        var byteLength = steps * 4;

        var msg = new LuaArray([0xF0, 0x47, 0x7F, 0x43, 0x65, 0x00, byteLength]);
        for(i in 0...steps) {
            var index = i + row * 16;
            msg.push(index);
            msg.push(0);
            msg.push(0);
            msg.push(0);
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