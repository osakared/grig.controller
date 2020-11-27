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

import fire.util.Signal0;
import fire.util.Signal1;

class Buttons
{
    public var hasDown (get, never) : Bool;
    public var change (default, null) : Signal0;
    public var onUp (default, null) : Signal1<Null<ButtonType>>;
    public var onDown (default, null) : Signal1<Null<ButtonType>>;

    public function new() : Void
    {
        this.change = new Signal0();
        this.onUp = new Signal1(null);
        this.onDown = new Signal1(null);
        _lengthDown = 0;
        _buttons = new Map<Int, Int>();
    }

    public function down(button :ButtonType) : Void
    {
        if(!_buttons.exists(button)) {
            _buttons.set(button, button);
            _lengthDown++;
            this.onDown.value = button;
            this.change.emit();
        }
    }

    public function up(button :ButtonType) : Void
    {
        if(_buttons.exists(button)) {
            _buttons.remove(button);
            _lengthDown--;
            this.onUp.value = button;
            this.change.emit();
        }
    }

    public function isButton(value :ButtonType) : Bool
    {
        return switch value {
            case ButtonType.ALT: true;
            case ButtonType.BROWSER: true;
            case ButtonType.DRUM: true;
            case ButtonType.FILTER: true;
            case ButtonType.GRID_LEFT: true;
            case ButtonType.GRID_RIGHT: true;
            case ButtonType.KNOB_TYPE: true;
            case ButtonType.MUTE_SOLO_1: true;
            case ButtonType.MUTE_SOLO_2: true;
            case ButtonType.MUTE_SOLO_3: true;
            case ButtonType.MUTE_SOLO_4: true;
            case ButtonType.NOTE: true;
            case ButtonType.PAN: true;
            case ButtonType.PATTERN_DOWN: true;
            case ButtonType.PATTERN_UP: true;
            case ButtonType.PATTERN_SONG: true;
            case ButtonType.PERFORM: true;
            case ButtonType.PLAY: true;
            case ButtonType.RECORD: true;
            case ButtonType.RESONANCE: true;
            case ButtonType.SELECT: true;
            case ButtonType.SHIFT: true;
            case ButtonType.STEP: true;
            case ButtonType.STOP: true;
            case ButtonType.VOLUME: true;
            case _: false;
        };
    }

    public inline function iterator() : Iterator<ButtonType>
    {
        return _buttons.iterator();
    }

    public inline function isDown(button :ButtonType) : Bool
    {
        return _buttons.exists(button);
    }

    private function get_hasDown() : Bool
    {
        return _lengthDown > 0;
    }

    private var _lengthDown :Int;
    private var _buttons :Map<ButtonType, ButtonType>;
}