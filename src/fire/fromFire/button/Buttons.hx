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
import fire.util.Signal1;
import fire.util.Cursor;

abstract Buttons(Map<ButtonType, Signal1<Bool>>) 
{
    public var knobType (get, never): Signal1<Bool>;
    public var volume (get, never): Signal1<Bool>;
    public var pan (get, never): Signal1<Bool>;
    public var filter (get, never): Signal1<Bool>;
    public var resonance (get, never): Signal1<Bool>;
    public var patternUp (get, never): Signal1<Bool>;
    public var patternDown (get, never): Signal1<Bool>;
    public var browser (get, never): Signal1<Bool>;
    public var select (get, never): Signal1<Bool>;
    public var gridLeft (get, never): Signal1<Bool>;
    public var gridRight (get, never): Signal1<Bool>;
    public var muteSolo1 (get, never): Signal1<Bool>;
    public var muteSolo2 (get, never): Signal1<Bool>;
    public var muteSolo3 (get, never): Signal1<Bool>;
    public var muteSolo4 (get, never): Signal1<Bool>;
    public var step (get, never): Signal1<Bool>;
    public var note (get, never): Signal1<Bool>;
    public var drum (get, never): Signal1<Bool>;
    public var perform (get, never): Signal1<Bool>;
    public var shift (get, never): Signal1<Bool>;
    public var alt (get, never): Signal1<Bool>;
    public var patternSong (get, never): Signal1<Bool>;
    public var play (get, never): Signal1<Bool>;
    public var stop (get, never): Signal1<Bool>;
    public var record (get, never): Signal1<Bool>;

    inline public function new(gridIndex :Signal1<Cursor>) {
        this = [
            KNOB_TYPE => new Signal1(false),
            VOLUME => new Signal1(false),
            PAN => new Signal1(false),
            FILTER => new Signal1(false),
            RESONANCE => new Signal1(false),
            PATTERN_UP => new Signal1(false),
            PATTERN_DOWN => new Signal1(false),
            BROWSER => new Signal1(false),
            SELECT => new Signal1(false),
            GRID_LEFT => new Signal1(false),
            GRID_RIGHT => new Signal1(false),
            MUTE_SOLO_1 => new Signal1(false),
            MUTE_SOLO_2 => new Signal1(false),
            MUTE_SOLO_3 => new Signal1(false),
            MUTE_SOLO_4 => new Signal1(false),
            STEP => new Signal1(false),
            NOTE => new Signal1(false),
            DRUM => new Signal1(false),
            PERFORM => new Signal1(false),
            SHIFT => new Signal1(false),
            ALT => new Signal1(false),
            PATTERN_SONG => new Signal1(false),
            PLAY => new Signal1(false),
            STOP => new Signal1(false),
            RECORD => new Signal1(false)
        ];
    }

    public inline function iterator() : Iterator<Signal1<Bool>>
    {
        return this.iterator();
    }

    public inline function exists(type :ButtonType) : Bool
    {
        return this.exists(type);
    }

    public inline function get(type :ButtonType) : Signal1<Bool>
    {
        return this.get(type);
    }

    private inline function get_knobType() : Signal1<Bool>
    {
        return this.get(ButtonType.KNOB_TYPE);
    }

    private inline function get_volume() : Signal1<Bool>
    {
        return this.get(ButtonType.VOLUME);
    }

    private inline function get_pan() : Signal1<Bool>
    {
        return this.get(ButtonType.PAN);
    }

    private inline function get_filter() : Signal1<Bool>
    {
        return this.get(ButtonType.FILTER);
    }

    private inline function get_resonance() : Signal1<Bool>
    {
        return this.get(ButtonType.RESONANCE);
    }

    private inline function get_patternUp() : Signal1<Bool>
    {
        return this.get(ButtonType.PATTERN_UP);
    }

    private inline function get_patternDown() : Signal1<Bool>
    {
        return this.get(ButtonType.PATTERN_DOWN);
    }

    private inline function get_browser() : Signal1<Bool>
    {
        return this.get(ButtonType.BROWSER);
    }

    private inline function get_select() : Signal1<Bool>
    {
        return this.get(ButtonType.SELECT);
    }

    private inline function get_gridLeft() : Signal1<Bool>
    {
        return this.get(ButtonType.GRID_LEFT);
    }

    private inline function get_gridRight() : Signal1<Bool>
    {
        return this.get(ButtonType.GRID_RIGHT);
    }

    private inline function get_muteSolo1() : Signal1<Bool>
    {
        return this.get(ButtonType.MUTE_SOLO_1);
    }

    private inline function get_muteSolo2() : Signal1<Bool>
    {
        return this.get(ButtonType.MUTE_SOLO_2);
    }

    private inline function get_muteSolo3() : Signal1<Bool>
    {
        return this.get(ButtonType.MUTE_SOLO_3);
    }

    private inline function get_muteSolo4() : Signal1<Bool>
    {
        return this.get(ButtonType.MUTE_SOLO_4);
    }

    private inline function get_step() : Signal1<Bool>
    {
        return this.get(ButtonType.STEP);
    }

    private inline function get_note() : Signal1<Bool>
    {
        return this.get(ButtonType.NOTE);
    }

    private inline function get_drum() : Signal1<Bool>
    {
        return this.get(ButtonType.DRUM);
    }

    private inline function get_perform() : Signal1<Bool>
    {
        return this.get(ButtonType.PERFORM);
    }

    private inline function get_shift() : Signal1<Bool>
    {
        return this.get(ButtonType.SHIFT);
    }

    private inline function get_alt() : Signal1<Bool>
    {
        return this.get(ButtonType.ALT);
    }

    private inline function get_patternSong() : Signal1<Bool>
    {
        return this.get(ButtonType.PATTERN_SONG);
    }

    private inline function get_play() : Signal1<Bool>
    {
        return this.get(ButtonType.PLAY);
    }

    private inline function get_stop() : Signal1<Bool>
    {
        return this.get(ButtonType.STOP);
    }

    private inline function get_record() : Signal1<Bool>
    {
        return this.get(ButtonType.RECORD);
    }
}