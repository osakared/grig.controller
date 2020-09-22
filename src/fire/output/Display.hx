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

package fire.output;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.util.LuaArray;

class Display
{
    private static inline var DISPLAY_WIDTH = 128;
    private static inline var DISPLAY_HEIGHT = 64;
    private static inline var LINE_HEIGHT = 8;
    private static inline var DATA_LENGTH = 1171; //Math.ceil((128 * 64) / 7) 01111111
    private static inline var DATA_INDEX_START = 12;

    public function new() : Void
    {
        this.initializeData();
    }

    public function clear() : Void
    {
        for(i in 0...DATA_LENGTH) {
            _msg[i + DATA_INDEX_START] = 0;
        }
    }

    public inline function render(output :MidiOutputDevice) : Void
    {
        output.send(_msg);
    }

    public function drawPixel(value :Int, x :Int, y :Int) : Void
    {
        var nX = x * LINE_HEIGHT;
        var nY = Math.floor(y / LINE_HEIGHT) * LINE_HEIGHT * DISPLAY_WIDTH + (y % LINE_HEIGHT);
        var pos = nX + nY;
        compactPixel(value, pos);
    }

    public function begin() : Void
    {

    }

    public function end(output :MidiOutputDevice) : Void
    {
        
    }

    private inline function compactPixel(value :Int, position :Int) : Void
    {
        var arrayIndex = Math.floor(position / 7) + DATA_INDEX_START;
        if(_msg[arrayIndex] == null) {
            _msg[arrayIndex] = 0;
        }
        var shiftLoc = 6 - (position % 7);
        var bitValue = value << shiftLoc;
        _msg[arrayIndex] = _msg[arrayIndex] | bitValue;
    };

    private inline function initializeData() : Void
    {
        var hh = (DATA_LENGTH + 4) >> 7;
        var ll = (DATA_LENGTH + 4) & 0x7F;
        _msg = new LuaArray([0xF0, 0x47, 0x7F, 0x43, 0x0E, hh, ll, 0x00, 0x07, 0x00, 0x7F]);
        for(i in 0...DATA_LENGTH) {
            _msg.push(0);
        }
        _msg.push(0xF7);
    }

    private var _msg :LuaArray<Int>; 
}
