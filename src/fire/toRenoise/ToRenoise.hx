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

package fire.toRenoise;

import fire.fromRenoise.RenoiseState;
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
    public function new(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
    {
        var softkeys = new SoftKeys();
        _grid = new Grid(softkeys);
        _buttonBehaviou = [
            GRID_LEFT => GridLeft.handle,
            GRID_RIGHT => GridRight.handle,
            SELECT => Select.handle,
            STEP => Step.handle,
            PLAY => Play.handle,
            STOP => Stop.handle,
            RECORD => Record.handle
        ];

        _dialBehaviou = [
            SELECT => SelectDial.handle
        ];

        initControllerState(softkeys, controllerState, renoiseState);
    }

    private function initControllerState(softkeys :SoftKeys, controllerState :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
    {
        controllerState.buttons.onDown.addListener((to) -> {
            if(_buttonBehaviou.exists(to)) {
                _buttonBehaviou.get(to)(true, softkeys, controllerState, renoiseState);
            }
        });
        controllerState.buttons.onUp.addListener((to) -> {
            if(_buttonBehaviou.exists(to)) {
                _buttonBehaviou.get(to)(false, softkeys, controllerState, renoiseState);
            }
        });

        controllerState.dials.onLeft.addListener((to) -> {
            if(_dialBehaviou.exists(to)) {
                _dialBehaviou.get(to)(true, softkeys, controllerState, renoiseState);
            }
        });
        controllerState.dials.onRight.addListener((to) -> {
            if(_dialBehaviou.exists(to)) {
                _dialBehaviou.get(to)(false, softkeys, controllerState, renoiseState);
            }
        });

        controllerState.grid.onDown.addListener((pad) -> {
            _grid.down(controllerState, renoiseState, pad);
        });

        controllerState.grid.onUp.addListener((pad) -> {
            _grid.up(controllerState, renoiseState, pad);
        });
    }

    private var _grid :Grid;
    private var _buttonBehaviou : Map<ButtonType, Behavior>;
    private var _dialBehaviou : Map<DialType, Behavior>;
}