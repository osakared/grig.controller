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

package fire.toFire;

import fire.util.Color;
import renoise.midi.Midi.MidiOutputDevice;
import lady.LArray;

class Grid
{
    private static inline var PADS = 16;
    private static inline var ROWS = 4;
    private static inline var BYTE_LENGTH = PADS * 4;
    private static inline var DATA_INDEX_START = 8;

    public function new(output :MidiOutputDevice) : Void
    {
        _rows = [];
        initializeData(output);
    }

    public function render(output :MidiOutputDevice) : Void
    {
        for(row in _rows) {
            output.send(row);
        }
    }

    public function draw(color :Color, pad :Int) : Void
    {
        var modPad = pad % (PADS * ROWS);
        pad %= PADS;
        var row = Math.floor(modPad / PADS);
        drawToPad(color.r, color.g, color.b, pad, row);
    }

    public function clear() : Void
    {
        for(row in 0...ROWS) {
            for(pad in 0...PADS) {
                drawToPad(0, 0, 0, pad, row);
            }
        }
    }

    private function initializeData(output :MidiOutputDevice) : Void
    {
        for(rowIndex in 0...ROWS) {
            var row :LArray<Int> = new LArray([0xF0, 0x47, 0x7F, 0x43, 0x65, 0x00, BYTE_LENGTH]);
            _rows.push(row);
            for(pad in 0...PADS) {
                drawToPad(0, 127, 0, pad, rowIndex);
            }
            row.push(0xF7);
        }
        this.render(output);
    }

    private function drawToPad(r :Int, g :Int, b :Int, pad :Int, row :Int) : Void
    {
        var padIndex = pad * 4 + DATA_INDEX_START;
        _rows[row][padIndex] = pad + PADS * row;
        _rows[row][padIndex + 1] = r;
        _rows[row][padIndex + 2] = g;
        _rows[row][padIndex + 3] = b;
    }

    private var _rows :Array<LArray<Int>>;
}