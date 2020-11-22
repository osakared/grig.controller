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

package fire.input.button;
import fire.util.ActiveKeys;

abstract Buttons(Map<ButtonType, Button>) 
{
    public var knobType (get, never): Button;
    public var volume (get, never): Button;
    public var pan (get, never): Button;
    public var filter (get, never): Button;
    public var resonance (get, never): Button;
    public var patternUp (get, never): Button;
    public var patternDown (get, never): Button;
    public var browser (get, never): Button;
    public var select (get, never): Button;
    public var gridLeft (get, never): Button;
    public var gridRight (get, never): Button;
    public var muteSolo1 (get, never): Button;
    public var muteSolo2 (get, never): Button;
    public var muteSolo3 (get, never): Button;
    public var muteSolo4 (get, never): Button;
    public var step (get, never): Button;
    public var note (get, never): Button;
    public var drum (get, never): Button;
    public var perform (get, never): Button;
    public var shift (get, never): Button;
    public var alt (get, never): Button;
    public var patternSong (get, never): Button;
    public var play (get, never): Button;
    public var stop (get, never): Button;
    public var record (get, never): Button;

    inline public function new(activeKeys :ActiveKeys) {
        this = [
            KNOB_TYPE => new Button(KNOB_TYPE, activeKeys),
            VOLUME => new Button(VOLUME, activeKeys),
            PAN => new Button(PAN, activeKeys),
            FILTER => new Button(FILTER, activeKeys),
            RESONANCE => new Button(RESONANCE, activeKeys),
            PATTERN_UP => new Button(PATTERN_UP, activeKeys),
            PATTERN_DOWN => new Button(PATTERN_DOWN, activeKeys),
            BROWSER => new Button(BROWSER, activeKeys),
            SELECT => new Select(SELECT, activeKeys),
            GRID_LEFT => new GridLeft(GRID_LEFT, activeKeys),
            GRID_RIGHT => new GridRight(GRID_RIGHT, activeKeys),
            MUTE_SOLO_1 => new Button(MUTE_SOLO_1, activeKeys),
            MUTE_SOLO_2 => new Button(MUTE_SOLO_2, activeKeys),
            MUTE_SOLO_3 => new Button(MUTE_SOLO_3, activeKeys),
            MUTE_SOLO_4 => new Button(MUTE_SOLO_4, activeKeys),
            STEP => new Step(STEP, activeKeys),
            NOTE => new Button(NOTE, activeKeys),
            DRUM => new Button(DRUM, activeKeys),
            PERFORM => new Button(PERFORM, activeKeys),
            SHIFT => new Button(SHIFT, activeKeys),
            ALT => new Button(ALT, activeKeys),
            PATTERN_SONG => new Button(PATTERN_SONG, activeKeys),
            PLAY => new Play(PLAY, activeKeys),
            STOP => new Stop(STOP, activeKeys),
            RECORD => new Button(RECORD, activeKeys)
        ];
    }

    public inline function iterator() : Iterator<Button>
    {
        return this.iterator();
    }

    public inline function exists(type :ButtonType) : Bool
    {
        return this.exists(type);
    }

    public inline function get(type :ButtonType) : Button
    {
        return this.get(type);
    }

    private inline function get_knobType() : Button
    {
        return this.get(ButtonType.KNOB_TYPE);
    }

    private inline function get_volume() : Button
    {
        return this.get(ButtonType.VOLUME);
    }

    private inline function get_pan() : Button
    {
        return this.get(ButtonType.PAN);
    }

    private inline function get_filter() : Button
    {
        return this.get(ButtonType.FILTER);
    }

    private inline function get_resonance() : Button
    {
        return this.get(ButtonType.RESONANCE);
    }

    private inline function get_patternUp() : Button
    {
        return this.get(ButtonType.PATTERN_UP);
    }

    private inline function get_patternDown() : Button
    {
        return this.get(ButtonType.PATTERN_DOWN);
    }

    private inline function get_browser() : Button
    {
        return this.get(ButtonType.BROWSER);
    }

    private inline function get_select() : Button
    {
        return this.get(ButtonType.SELECT);
    }

    private inline function get_gridLeft() : Button
    {
        return this.get(ButtonType.GRID_LEFT);
    }

    private inline function get_gridRight() : Button
    {
        return this.get(ButtonType.GRID_RIGHT);
    }

    private inline function get_muteSolo1() : Button
    {
        return this.get(ButtonType.MUTE_SOLO_1);
    }

    private inline function get_muteSolo2() : Button
    {
        return this.get(ButtonType.MUTE_SOLO_2);
    }

    private inline function get_muteSolo3() : Button
    {
        return this.get(ButtonType.MUTE_SOLO_3);
    }

    private inline function get_muteSolo4() : Button
    {
        return this.get(ButtonType.MUTE_SOLO_4);
    }

    private inline function get_step() : Button
    {
        return this.get(ButtonType.STEP);
    }

    private inline function get_note() : Button
    {
        return this.get(ButtonType.NOTE);
    }

    private inline function get_drum() : Button
    {
        return this.get(ButtonType.DRUM);
    }

    private inline function get_perform() : Button
    {
        return this.get(ButtonType.PERFORM);
    }

    private inline function get_shift() : Button
    {
        return this.get(ButtonType.SHIFT);
    }

    private inline function get_alt() : Button
    {
        return this.get(ButtonType.ALT);
    }

    private inline function get_patternSong() : Button
    {
        return this.get(ButtonType.PATTERN_SONG);
    }

    private inline function get_play() : Button
    {
        return this.get(ButtonType.PLAY);
    }

    private inline function get_stop() : Button
    {
        return this.get(ButtonType.STOP);
    }

    private inline function get_record() : Button
    {
        return this.get(ButtonType.RECORD);
    }
}