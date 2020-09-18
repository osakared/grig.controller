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

package fire.button;

import renoise.midi.Midi.MidiOutputDevice;

class Buttons
{

    public function new() : Void
    {
        _buttons = [
            KNOB_TYPE => new KnobType(KNOB_TYPE),
            VOLUME => new Volume(VOLUME),
            PAN => new Pan(PAN),
            FILTER => new Filter(FILTER),
            RESONANCE => new Resonance(RESONANCE),
            PATTERN_UP => new PatternUp(PATTERN_UP),
            PATTERN_DOWN => new PatternDown(PATTERN_DOWN),
            BROWSER => new Browser(BROWSER),
            SELECT => new Select(SELECT),
            GRID_LEFT => new GridLeft(GRID_LEFT),
            GRID_RIGHT => new GridRight(GRID_RIGHT),
            MUTE_SOLO_1 => new MuteSolo(MUTE_SOLO_1),
            MUTE_SOLO_2 => new MuteSolo(MUTE_SOLO_2),
            MUTE_SOLO_3 => new MuteSolo(MUTE_SOLO_3),
            MUTE_SOLO_4 => new MuteSolo(MUTE_SOLO_4),
            STEP => new Step(STEP),
            NOTE => new Note(NOTE),
            DRUM => new Drum(DRUM),
            PERFORM => new Perform(PERFORM),
            SHIFT => new Shift(SHIFT),
            ALT => new Alt(ALT),
            PATTERN_SONG => new PatternSong(PATTERN_SONG),
            PLAY => new Play(PLAY),
            STOP => new Stop(STOP),
            RECORD => new Record(RECORD)
        ];
    }

    public inline function iterator() : Iterator<Button>
    {
        return _buttons.iterator();
    }

    public inline function exists(type :ButtonType) : Bool
    {
        return _buttons.exists(type);
    }

    public inline function get(type :ButtonType) : Button
    {
        return _buttons.get(type);
    }

    public inline function initialize(output :MidiOutputDevice, display :Display) : Void
    {
        for(button in _buttons) {
            button.initialize(output, display);
        }
    }

    private var _buttons : Map<ButtonType, Button>;
}