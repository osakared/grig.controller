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

import renoise.midi.Midi.MidiOutputDevice;
import fire.LuaArray;
import renoise.Renoise;
import renoise.RenoiseUtil;

class Grid implements Initializable
{
    public function new() : Void
    {
        _lastIndex = -1;
        _scratchItem = lua.Table.create();
    }

    public function initialize(output :MidiOutputDevice, display :Display) : Void
    {
        colorRow(output, 0, 0);
        colorRow(output, 1, 0);
        colorRow(output, 2, 0);
        colorRow(output, 3, 0);

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            var transport = Renoise.song().transport;
            var index = transport.playbackPos.line - 1;
            sendColor(output, index, 0x7F);
        });
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

    public function colorIndex(output :MidiOutputDevice, index :Int) : Void
    {
        sendColor(output, index, 0x7F);

        if(_lastIndex != -1) {
            sendColor(output, _lastIndex, 0);
        }

        _lastIndex = index;
    }

    public function handleButtonIndex(output :MidiOutputDevice, button :Int) : Void
    {
        var line = button - 54 + 1;
        RenoiseUtil.setLine(line, 64);
    }

    private inline function sendColor(output :MidiOutputDevice, index :Int, color :Int) : Void
    {
        _scratchItem[1] = 0xF0;
        _scratchItem[2] = 0x47;
        _scratchItem[3] = 0x7F;
        _scratchItem[4] = 0x43;
        _scratchItem[5] = 0x65;
        _scratchItem[6] = 0x00;
        _scratchItem[7] = 0x04;
        _scratchItem[8] = index;
        _scratchItem[9] = color;
        _scratchItem[10] = color;
        _scratchItem[11] = color;
        _scratchItem[12] = 0xF7;
        output.send(cast _scratchItem);
    }

    private var _lastIndex :Int;
    private var _scratchItem :lua.Table<Int, Int>;
}