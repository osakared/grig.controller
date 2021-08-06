/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any peon obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit peons to whom the Software is furnished to do so,
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

package lady.display;

import lady.LArray;
import lady.renoise.midi.Midi.MidiOutputDevice;

class Display
{
    private static inline var DISPLAY_WIDTH = 128;
    private static inline var DISPLAY_HEIGHT = 64;
    private static inline var LINE_HEIGHT = 8;
    private static inline var ROW_LENGTH = 147; //Math.ceil((128 * 8) / 7) 01111111
    private static inline var DATA_INDEX_START = 12;

    public function new() : Void
    {
        this.initializeData();
    }

    public function clear() : Void
    {
        for(row in _rows) {
            for(i in 0...ROW_LENGTH) {
                row[i + DATA_INDEX_START] = 0;
            }
        }
    }

    public inline function render(output :MidiOutputDevice) : Void
    {
        for(row in _rows) {
            output.send(row);
        }
    }

    public inline function renderRow(output :MidiOutputDevice, index :Int) : Void
    {
        output.send(_rows[index]);
    }

    public function drawPixel(value :Int, x :Int, y :Int) : Void
    {
        if(x >= 0 && x < DISPLAY_WIDTH && y >= 0 && y < DISPLAY_HEIGHT) {
            var row = Std.int(y/LINE_HEIGHT);
            y = y % 8;
            var nX = x * LINE_HEIGHT;
            var rY = 7 - (y % LINE_HEIGHT);
            var nY = Math.floor(rY / LINE_HEIGHT) * LINE_HEIGHT * DISPLAY_WIDTH + (rY % LINE_HEIGHT);
            var pos = nX + nY;
            compactPixel(_rows[row], value, pos);
        }
    }

    public function drawText(text :String, x :Int, y :Int, underline :Bool, invert :Bool) : Int
    {
        var lette = Text.make(text);
        var yIndex = 0;
        var maxUnderlines = 6 * text.length - 1;
        for(line in lette) {
            var xIndex = 0;
            for(value in line) {
                if(underline && yIndex == 7 && xIndex < maxUnderlines) {
                    value = 1;
                }
                if(invert) {
                    value = (value == 0) ? 1 : 0;
                }
                drawPixel(value, xIndex + x, yIndex + y);
                xIndex++;
            }
            yIndex++;
        }

        return x + 6 * text.length;
    }

    private inline function compactPixel(row :LArray<Int>, value :Int, position :Int) : Void
    {
        var arrayIndex = Math.floor(position / 7) + DATA_INDEX_START;
        if(row[arrayIndex] == null) {
            row[arrayIndex] = 0;
        }
        var shiftLoc = 6 - (position % 7);
        var bitValue = value << shiftLoc;
        row[arrayIndex] = row[arrayIndex] | bitValue;
    };

    private inline function initializeData() : Void
    {
        var hh = (ROW_LENGTH + 4) >> 7;
        var ll = (ROW_LENGTH + 4) & 0x7F;
        for(rowIndex in 0...8) {
            var row :LArray<Int> = new LArray([0xF0, 0x47, 0x7F, 0x43, 0x0E, hh, ll, rowIndex, 0x07, 0x00, 0x7F]);
            for(_ in 0...ROW_LENGTH) {
                row.push(0);
            }
            row.push(0xF7);
            _rows.push(row);
        }
    }

    private var _rows :Array<LArray<Int>> = [];
}
