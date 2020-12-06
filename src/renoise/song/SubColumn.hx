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

package renoise.song;

@:native("renoise.Song")
extern enum abstract SubColumn(Int)
{
    @:native("SUB_COLUMN_NOTE")
    var NOTE;
    @:native("SUB_COLUMN_INSTRUMENT")
    var INSTRUMENT;
    @:native("SUB_COLUMN_VOLUME")
    var VOLUME;
    @:native("SUB_COLUMN_PANNING")
    var PANNING;
    @:native("SUB_COLUMN_DELAY")
    var DELAY;
    
    @:native("SUB_COLUMN_SAMPLE_EFFECT_NUMBER")
    var SAMPLE_EFFECT_NUMBER;
    @:native("SUB_COLUMN_SAMPLE_EFFECT_AMOUNT")
    var SAMPLE_EFFECT_AMOUNT;

    @:native("SUB_COLUMN_EFFECT_NUMBER")
    var EFFECT_NUMBER;
    @:native("SUB_COLUMN_EFFECT_AMOUNT")
    var EFFECT_AMOUNT;
}