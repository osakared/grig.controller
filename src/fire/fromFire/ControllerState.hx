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

package fire.fromFire;

import fire.fromFire.button.ButtonType;
import fire.fromFire.dial.Dials;
import fire.fromFire.grid.Grid;
import fire.fromFire.button.Buttons;
import fire.util.Signal1;

class ControllerState
{
    public var dials (default, null) : Dials;
    public var input (default, null):Signal1<InputState>;
    public var grid (default, null):Grid;
    public var buttons (default, null):Buttons;

    public function new() {
        this.dials = new Dials();
        this.input = new Signal1(STEP);
        this.grid = new Grid();
        this.buttons = new Buttons();
        initInput();
    }

    private function initInput() : Void
    {
        this.buttons.onDown.addListener(type -> {
            handleButtonDown(type);
        });
    }

    private function handleButtonDown(type :ButtonType) : Void
    {
        switch type {
            case STEP:
                this.input.value = STEP;
            case NOTE:
                this.input.value = NOTE;
            case DRUM:
                this.input.value = DRUM;
            case PERFORM:
                this.input.value = PERFORM;
            case _:
        }
    }
}

enum InputState
{
    STEP;
    NOTE;
    DRUM;
    PERFORM;
}