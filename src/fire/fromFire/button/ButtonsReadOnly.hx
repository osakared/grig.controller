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

package fire.fromFire.button;

import fire.util.SignalReadOnly;

abstract ButtonsReadOnly(Buttons) from Buttons
{
    public var knobType (get, never): ButtonReadOnly;
    public var volume (get, never): ButtonReadOnly;
    public var pan (get, never): ButtonReadOnly;
    public var filter (get, never): ButtonReadOnly;
    public var resonance (get, never): ButtonReadOnly;
    public var patternUp (get, never): ButtonReadOnly;
    public var patternDown (get, never): ButtonReadOnly;
    public var browser (get, never): ButtonReadOnly;
    public var select (get, never): ButtonReadOnly;
    public var gridLeft (get, never): ButtonReadOnly;
    public var gridRight (get, never): ButtonReadOnly;
    public var muteSolo1 (get, never): ButtonReadOnly;
    public var muteSolo2 (get, never): ButtonReadOnly;
    public var muteSolo3 (get, never): ButtonReadOnly;
    public var muteSolo4 (get, never): ButtonReadOnly;
    public var step (get, never): ButtonReadOnly;
    public var note (get, never): ButtonReadOnly;
    public var drum (get, never): ButtonReadOnly;
    public var perform (get, never): ButtonReadOnly;
    public var shift (get, never): ButtonReadOnly;
    public var alt (get, never): ButtonReadOnly;
    public var patternSong (get, never): ButtonReadOnly;
    public var play (get, never): ButtonReadOnly;
    public var stop (get, never): ButtonReadOnly;
    public var record (get, never): ButtonReadOnly;

    private inline function get_knobType() : ButtonReadOnly
    {
        return this.knobType;
    }

    private inline function get_volume() : ButtonReadOnly
    {
        return this.volume;
    }

    private inline function get_pan() : ButtonReadOnly
    {
        return this.pan;
    }

    private inline function get_filter() : ButtonReadOnly
    {
        return this.filter;
    }

    private inline function get_resonance() : ButtonReadOnly
    {
        return this.resonance;
    }

    private inline function get_patternUp() : ButtonReadOnly
    {
        return this.patternUp;
    }

    private inline function get_patternDown() : ButtonReadOnly
    {
        return this.patternDown;
    }

    private inline function get_browser() : ButtonReadOnly
    {
        return this.browser;
    }

    private inline function get_select() : ButtonReadOnly
    {
        return this.select;
    }

    private inline function get_gridLeft() : ButtonReadOnly
    {
        return this.gridLeft;
    }

    private inline function get_gridRight() : ButtonReadOnly
    {
        return this.gridRight;
    }

    private inline function get_muteSolo1() : ButtonReadOnly
    {
        return this.muteSolo1;
    }

    private inline function get_muteSolo2() : ButtonReadOnly
    {
        return this.muteSolo2;
    }

    private inline function get_muteSolo3() : ButtonReadOnly
    {
        return this.muteSolo3;
    }

    private inline function get_muteSolo4() : ButtonReadOnly
    {
        return this.muteSolo4;
    }

    private inline function get_step() : ButtonReadOnly
    {
        return this.step;
    }

    private inline function get_note() : ButtonReadOnly
    {
        return this.note;
    }

    private inline function get_drum() : ButtonReadOnly
    {
        return this.drum;
    }

    private inline function get_perform() : ButtonReadOnly
    {
        return this.perform;
    }

    private inline function get_shift() : ButtonReadOnly
    {
        return this.shift;
    }

    private inline function get_alt() : ButtonReadOnly
    {
        return this.alt;
    }

    private inline function get_patternSong() : ButtonReadOnly
    {
        return this.patternSong;
    }

    private inline function get_play() : ButtonReadOnly
    {
        return this.play;
    }

    private inline function get_stop() : ButtonReadOnly
    {
        return this.stop;
    }

    private inline function get_record() : ButtonReadOnly
    {
        return this.record;
    }
}

abstract ButtonReadOnly(Button) from Button
{
    public var type (get, never) : ButtonType;
    public var isDown (get, never) : SignalReadOnly<Bool>;

    private inline function get_type() : ButtonType
    {
        return this.type;
    }

    private inline function get_isDown() : SignalReadOnly<Bool>
    {
        return this.isDown;
    }
}