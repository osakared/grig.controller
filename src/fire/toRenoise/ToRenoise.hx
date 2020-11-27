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
    public function new(buttons :ControllerStateReadOnly) : Void
    {
        _grid = new Grid();
        initButtons(buttons);
        initDials(buttons);
    }

    private function initButtons(buttons :ControllerStateReadOnly) : Void
    {
        buttons.gridLeft.addListener((isDown, _) -> GridLeft.handle(isDown));
        buttons.gridRight.addListener((isDown, _) -> GridRight.handle(isDown));
        buttons.select.addListener((isDown, _) -> Select.handle(isDown));
        buttons.step.addListener((isDown, _) -> Step.handle(isDown));
        buttons.play.addListener((isDown, _) -> Play.handle(isDown));
        buttons.stop.addListener((isDown, _) -> Stop.handle(isDown));
        buttons.record.addListener((isDown, _) -> Record.handle(isDown));

        for(i in 0...64) {
            buttons.padConnect(i).addListener((isDown, _) -> {
                if(isDown) {
                    _grid.down(buttons, i);
                }
                else {
                    _grid.up(buttons, i);
                }
            });
        }
    }

    private function initDials(buttons :ControllerStateReadOnly) : Void
    {
        buttons.dials.select.left.addListener(SelectDial.onLeft.bind(buttons));
        buttons.dials.select.right.addListener(SelectDial.onRight.bind(buttons));
    }

    private var _grid :Grid;
}