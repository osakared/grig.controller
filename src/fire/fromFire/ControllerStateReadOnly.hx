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

package fire.fromFire;

import fire.fromFire.grid.GridReadOnly;
import fire.fromFire.dial.DialsReadOnly;
import fire.fromFire.ControllerState.InputState;
import fire.util.Signal0ReadOnly;
import fire.util.Signal1ReadOnly;

abstract ControllerStateReadOnly(ControllerState) from ControllerState
{
    public var knobType (get, never): Signal1ReadOnly<Bool>;
    public var volume (get, never): Signal1ReadOnly<Bool>;
    public var pan (get, never): Signal1ReadOnly<Bool>;
    public var filter (get, never): Signal1ReadOnly<Bool>;
    public var resonance (get, never): Signal1ReadOnly<Bool>;
    public var patternUp (get, never): Signal1ReadOnly<Bool>;
    public var patternDown (get, never): Signal1ReadOnly<Bool>;
    public var browser (get, never): Signal1ReadOnly<Bool>;
    public var select (get, never): Signal1ReadOnly<Bool>;
    public var gridLeft (get, never): Signal1ReadOnly<Bool>;
    public var gridRight (get, never): Signal1ReadOnly<Bool>;
    public var muteSolo1 (get, never): Signal1ReadOnly<Bool>;
    public var muteSolo2 (get, never): Signal1ReadOnly<Bool>;
    public var muteSolo3 (get, never): Signal1ReadOnly<Bool>;
    public var muteSolo4 (get, never): Signal1ReadOnly<Bool>;
    public var step (get, never): Signal1ReadOnly<Bool>;
    public var note (get, never): Signal1ReadOnly<Bool>;
    public var drum (get, never): Signal1ReadOnly<Bool>;
    public var perform (get, never): Signal1ReadOnly<Bool>;
    public var shift (get, never): Signal1ReadOnly<Bool>;
    public var alt (get, never): Signal1ReadOnly<Bool>;
    public var patternSong (get, never): Signal1ReadOnly<Bool>;
    public var play (get, never): Signal1ReadOnly<Bool>;
    public var stop (get, never): Signal1ReadOnly<Bool>;
    public var record (get, never): Signal1ReadOnly<Bool>;
    public var dials (get, never) : DialsReadOnly;
    public var input (get, never) : Signal1ReadOnly<InputState>;
    public var grid (get, never) : GridReadOnly;

    private inline function get_knobType() : Signal1ReadOnly<Bool>
    {
        return this.knobType;
    }

    private inline function get_volume() : Signal1ReadOnly<Bool>
    {
        return this.volume;
    }

    private inline function get_pan() : Signal1ReadOnly<Bool>
    {
        return this.pan;
    }

    private inline function get_filter() : Signal1ReadOnly<Bool>
    {
        return this.filter;
    }

    private inline function get_resonance() : Signal1ReadOnly<Bool>
    {
        return this.resonance;
    }

    private inline function get_patternUp() : Signal1ReadOnly<Bool>
    {
        return this.patternUp;
    }

    private inline function get_patternDown() : Signal1ReadOnly<Bool>
    {
        return this.patternDown;
    }

    private inline function get_browser() : Signal1ReadOnly<Bool>
    {
        return this.browser;
    }

    private inline function get_select() : Signal1ReadOnly<Bool>
    {
        return this.select;
    }

    private inline function get_gridLeft() : Signal1ReadOnly<Bool>
    {
        return this.gridLeft;
    }

    private inline function get_gridRight() : Signal1ReadOnly<Bool>
    {
        return this.gridRight;
    }

    private inline function get_muteSolo1() : Signal1ReadOnly<Bool>
    {
        return this.muteSolo1;
    }

    private inline function get_muteSolo2() : Signal1ReadOnly<Bool>
    {
        return this.muteSolo2;
    }

    private inline function get_muteSolo3() : Signal1ReadOnly<Bool>
    {
        return this.muteSolo3;
    }

    private inline function get_muteSolo4() : Signal1ReadOnly<Bool>
    {
        return this.muteSolo4;
    }

    private inline function get_step() : Signal1ReadOnly<Bool>
    {
        return this.step;
    }

    private inline function get_note() : Signal1ReadOnly<Bool>
    {
        return this.note;
    }

    private inline function get_drum() : Signal1ReadOnly<Bool>
    {
        return this.drum;
    }

    private inline function get_perform() : Signal1ReadOnly<Bool>
    {
        return this.perform;
    }

    private inline function get_shift() : Signal1ReadOnly<Bool>
    {
        return this.shift;
    }

    private inline function get_alt() : Signal1ReadOnly<Bool>
    {
        return this.alt;
    }

    private inline function get_patternSong() : Signal1ReadOnly<Bool>
    {
        return this.patternSong;
    }

    private inline function get_play() : Signal1ReadOnly<Bool>
    {
        return this.play;
    }

    private inline function get_stop() : Signal1ReadOnly<Bool>
    {
        return this.stop;
    }

    private inline function get_record() : Signal1ReadOnly<Bool>
    {
        return this.record;
    }

    private inline function get_dials() : DialsReadOnly
    {
        return this.dials;
    }

    private inline function get_input() : Signal1ReadOnly<InputState>
    {
        return this.input;
    }

    private inline function get_grid() : GridReadOnly
    {
        return this.grid;
    }
}