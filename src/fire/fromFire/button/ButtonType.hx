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

package fire.fromFire.button;

@:enum
abstract ButtonType(Int) from Int to Int
{
    var KNOB_TYPE = 26;
    var VOLUME = 16;
    var PAN = 17;
    var FILTER = 18;
    var RESONANCE = 19;
    var PATTERN_UP = 31;
    var PATTERN_DOWN = 32;
    var BROWSER = 33;
    var SELECT = 25;
    var GRID_LEFT = 34;
    var GRID_RIGHT = 35;
    var MUTE_SOLO_1 = 36;
    var MUTE_SOLO_2 = 37;
    var MUTE_SOLO_3 = 38;
    var MUTE_SOLO_4 = 39;
    var STEP = 44;
    var NOTE = 45;
    var DRUM = 46;
    var PERFORM = 47;
    var SHIFT = 48;
    var ALT = 49;
    var PATTERN_SONG = 50;
    var PLAY = 51;
    var STOP = 52;
    var RECORD = 53;
}