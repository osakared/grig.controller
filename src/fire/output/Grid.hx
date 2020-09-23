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

import renoise.midi.Midi.MidiOutputDevice;
import fire.util.LuaArray;

class Grid
{
    private static inline var STEPS = 16;
    private static inline var ROWS = 4;
    private static inline var BYTE_LENGTH = STEPS * 4;
    private static inline var DATA_INDEX_START = 8;

    public function new() : Void
    {
        _rows = [];
        initializeData();
    }

    public function render(output :MidiOutputDevice) : Void
    {
        for(row in _rows) {
            output.send(row);
        }
    }

    public function drawPixel(r :Int, g :Int, b :Int, step :Int) : Void
    {
        var modStep = step % (STEPS * ROWS);
        step %= STEPS;
        var row = Math.floor(modStep / STEPS);
        drawToPad(r, g, b, step, row);
    }

    public function clear() : Void
    {
        for(row in 0...ROWS) {
            for(step in 0...STEPS) {
                drawToPad(0, 0, 0, step, row);
            }
        }
    }

    private function initializeData() : Void
    {
        for(rowIndex in 0...ROWS) {
            var row = new LuaArray([0xF0, 0x47, 0x7F, 0x43, 0x65, 0x00, BYTE_LENGTH]);
            _rows.push(row);
            for(step in 0...STEPS) {
                drawToPad(127, 127, 0, step, rowIndex);
            }
            row.push(0xF7);
        }
    }

    private function drawToPad(r :Int, g :Int, b :Int, step :Int, row :Int) : Void
    {
        var padIndex = step + row * STEPS;
        var stepIndex = step * 4 + DATA_INDEX_START;
        _rows[row][stepIndex] = padIndex;
        _rows[row][stepIndex + 1] = r;
        _rows[row][stepIndex + 2] = g;
        _rows[row][stepIndex + 3] = b;
    }

    private var _rows :Array<LuaArray<Int>>;
}