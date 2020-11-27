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

package fire.toRenoise;

import fire.fromFire.button.ButtonType;
import fire.fromFire.dial.DialsReadOnly;
import fire.fromFire.ControllerStateReadOnly;
import fire.toRenoise.button.GridLeft;
import fire.toRenoise.button.GridRight;
import fire.toRenoise.button.Play;
import fire.toRenoise.button.Select;
import fire.toRenoise.button.Step;
import fire.toRenoise.button.Stop;
import fire.toRenoise.button.Record;
import fire.toRenoise.dial.Select as SelectDial;

class ToRenoise
{
    public function new(controllerState :ControllerStateReadOnly) : Void
    {
        _grid = new Grid();
        _buttonBehaviours = [
            GRID_LEFT => GridLeft.handle,
            GRID_RIGHT => GridRight.handle,
            SELECT => Select.handle,
            STEP => Step.handle,
            PLAY => Play.handle,
            STOP => Stop.handle,
            RECORD => Record.handle
        ];
        initcontrollerState(controllerState);
        initDials(controllerState);
    }

    private function initcontrollerState(controllerState :ControllerStateReadOnly) : Void
    {
        controllerState.buttons.onDown.addListener((to, _) -> {
            if(_buttonBehaviours.exists(to)) {
                _buttonBehaviours.get(to)(true, controllerState);
            }
        });
        controllerState.buttons.onUp.addListener((to, _) -> {
            if(_buttonBehaviours.exists(to)) {
                _buttonBehaviours.get(to)(false, controllerState);
            }
        });

        controllerState.grid.onDown.addListener((pad, _) -> {
            _grid.down(controllerState, pad);
        });

        controllerState.grid.onUp.addListener((pad, _) -> {
            _grid.up(controllerState, pad);
        });
    }

    private function initDials(controllerState :ControllerStateReadOnly) : Void
    {
        controllerState.dials.onLeft.addListener((to, _) -> {
            switch to {
                case SELECT:
                    SelectDial.onLeft(controllerState);
                case _:
            }
        });
        controllerState.dials.onRight.addListener((to, _) -> {
            switch to {
                case SELECT:
                    SelectDial.onRight(controllerState);
                case _:
            }
        });
    }

    private var _grid :Grid;
    private var _buttonBehaviours : Map<ButtonType, (isDown :Bool, controllerState :ControllerStateReadOnly) -> Void>;
}