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

package fire.output.button;

import fire.input.button.ButtonType;

class ButtonLights
{
    public var knobType = new ButtonLight(ButtonType.KNOB_TYPE);
    public var patternUp = new ButtonLight(ButtonType.PATTERN_UP);
    public var patternDown = new ButtonLight(ButtonType.PATTERN_DOWN);
    public var browser = new ButtonLight(ButtonType.BROWSER);
    public var gridLeft = new ButtonLight(ButtonType.GRID_LEFT);
    public var gridRight = new ButtonLight(ButtonType.GRID_RIGHT);
    public var muteSolo1 = new ButtonLight(ButtonType.MUTE_SOLO_1);
    public var muteSolo2 = new ButtonLight(ButtonType.MUTE_SOLO_2);
    public var muteSolo3 = new ButtonLight(ButtonType.MUTE_SOLO_3);
    public var muteSolo4 = new ButtonLight(ButtonType.MUTE_SOLO_4);
    public var step = new ButtonLight(ButtonType.STEP);
    public var note = new ButtonLight(ButtonType.NOTE);
    public var drum = new ButtonLight(ButtonType.DRUM);
    public var perform = new ButtonLight(ButtonType.PERFORM);
    public var shift = new ButtonLight(ButtonType.SHIFT);
    public var alt = new ButtonLight(ButtonType.ALT);
    public var patternSong = new ButtonLight(ButtonType.PATTERN_SONG);
    public var play = new ButtonLight(ButtonType.PLAY);
    public var stop = new ButtonLight(ButtonType.STOP);
    public var record = new ButtonLight(ButtonType.RECORD);

    public function new() : Void
    {
    }
}