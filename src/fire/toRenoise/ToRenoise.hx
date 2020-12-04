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

import fire.fromFire.dial.DialType;
import fire.toRenoise.SoftKeys;
import fire.fromFire.button.ButtonType;
import fire.fromFire.ControllerStateReadOnly;
import fire.toRenoise.behavior.Behavior;
import fire.toRenoise.behavior.button.GridLeft;
import fire.toRenoise.behavior.button.GridRight;
import fire.toRenoise.behavior.button.Play;
import fire.toRenoise.behavior.button.Select;
import fire.toRenoise.behavior.button.Step;
import fire.toRenoise.behavior.button.Stop;
import fire.toRenoise.behavior.button.Record;
import fire.toRenoise.behavior.dial.Select as SelectDial;

class ToRenoise
{
    public function new(controllerState :ControllerStateReadOnly) : Void
    {
        var softkeys = new SoftKeys();
        _grid = new Grid(softkeys);
        _buttonBehaviours = [
            GRID_LEFT => GridLeft.handle,
            GRID_RIGHT => GridRight.handle,
            SELECT => Select.handle,
            STEP => Step.handle,
            PLAY => Play.handle,
            STOP => Stop.handle,
            RECORD => Record.handle
        ];

        _dialBehaviours = [
            SELECT => SelectDial.handle
        ];

        initControllerState(softkeys, controllerState);
    }

    private function initControllerState(softkeys :SoftKeys, controllerState :ControllerStateReadOnly) : Void
    {
        controllerState.buttons.onDown.addListener((to) -> {
            if(_buttonBehaviours.exists(to)) {
                _buttonBehaviours.get(to)(true, softkeys, controllerState);
            }
        });
        controllerState.buttons.onUp.addListener((to) -> {
            if(_buttonBehaviours.exists(to)) {
                _buttonBehaviours.get(to)(false, softkeys, controllerState);
            }
        });

        controllerState.dials.onLeft.addListener((to) -> {
            if(_dialBehaviours.exists(to)) {
                _dialBehaviours.get(to)(true, softkeys, controllerState);
            }
        });
        controllerState.dials.onRight.addListener((to) -> {
            if(_dialBehaviours.exists(to)) {
                _dialBehaviours.get(to)(false, softkeys, controllerState);
            }
        });

        controllerState.grid.onDown.addListener((pad) -> {
            _grid.down(controllerState, pad);
        });

        controllerState.grid.onUp.addListener((pad) -> {
            _grid.up(controllerState, pad);
        });
    }

    private var _grid :Grid;
    private var _buttonBehaviours : Map<ButtonType, Behavior>;
    private var _dialBehaviours : Map<DialType, Behavior>;
}