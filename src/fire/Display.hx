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

class Display implements Initializable
{
    private static var DISPLAY_WIDTH = 128;
    private static var DISPLAY_HEIGHT = 64;

    public function new() : Void
    {
        _bitmap = new LuaArray([]);
        _data = new LuaArray([]);
        _msg = new LuaArray([]);
        _bytes = new LuaArray([]);
    }

    public function initialize(modifiers :Modifiers, output :MidiOutputDevice, display :Display) : Void
    {
    }

    public function clear(output :MidiOutputDevice, row :Int) : Void
    {
        var length = 8 * 128;
        _bitmap.clear();
        for(i in 0...length) {
            _bitmap[i] = 0;
        }
        render(output, row, 0x00, 0x7F);
    }

    public function render(output :MidiOutputDevice, row :Int, columnStart :Int, columnEnd :Int = 0x7F) : Void
    {
        var binaryData = convertBitmap();
        var data = bitsToInt(binaryData);
        drawBitmap(output, data, row, row, columnStart, columnEnd);
        _bitmap.clear();
    }

    public function drawString(letter :Array<Array<Int>>) : Void
    {
        var yIndex = 0;
        for(line in letter) {
            var xIndex = 0;
            for(value in line) {
                var pos = (yIndex) * DISPLAY_WIDTH + xIndex;
                _bitmap[pos] = value;
                xIndex++;
            }
            yIndex++;
        }
    }

    private function drawBitmap(output :MidiOutputDevice, data :LuaArray<Int>, rowStart :Int, rowEnd :Int, columnStart :Int, columnEnd) : Void
    {
        _msg.clear();
        var hh = (data.length + 4) >> 7;
        var ll = (data.length + 4) & 0x7F;
        _msg.push(0xF0);
        _msg.push(0x47);
        _msg.push(0x7F);
        _msg.push(0x43);
        _msg.push(0x0E);
        _msg.push(hh);
        _msg.push(ll);
        _msg.push(rowStart);
        _msg.push(rowEnd);
        _msg.push(columnStart);
        _msg.push(columnEnd);
        for(pixel in data) {
            _msg.push(pixel);
        }
        _msg.push(0xF7);
        output.send(_msg);
    }

    private function bitsToInt(byteArray :LuaArray<Int>) : LuaArray<Int>
    {
        _bytes.clear();
        for(i in 0...byteArray.length) {
            var arrayIndex = Math.floor(i / 7);
            if(_bytes[arrayIndex] == null) {
                _bytes[arrayIndex] = 0;
            }
            _bytes[arrayIndex] = (_bytes[arrayIndex] << 1) | byteArray[i];
        }

        return _bytes;
    };

    private function convertBitmap() : LuaArray<Int>
    {
        var L = 8;
        var screenWidth = DISPLAY_WIDTH;

        for(y in 0...DISPLAY_HEIGHT) {
            for(x in 0...DISPLAY_WIDTH) {
                var nX = x * L;
                var nY = Math.floor(y / L) * L * screenWidth + (y % L);
                var rY = 7 - (y % 8) + (8 * Std.int(y/8));
                var displayIndex :Int = nX + nY;
                var pos = rY*DISPLAY_WIDTH + x;
                _data[displayIndex] = _bitmap[pos];
            }  
        }

        return _data;
    }

    private var _bitmap :LuaArray<Int>; 
    private var _data :LuaArray<Int>; 
    private var _bytes :LuaArray<Int>; 
    private var _msg :LuaArray<Int>; 
}
