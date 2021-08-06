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

import fire.fromFire.button.ButtonsReadOnly;
import fire.fromFire.grid.GridReadOnly;
import fire.fromFire.dial.DialsReadOnly;
import fire.fromFire.ControllerState.InputState;
import fire.fromFire.ControllerState.BrowserState;
import fire.fromFire.ControllerState.SettingSelection;
import fire.util.Signal1ReadOnly;

abstract ControllerStateReadOnly(ControllerState) from ControllerState
{
    public var dials (get, never) : DialsReadOnly;
    public var input (get, never) : Signal1ReadOnly<InputState>;
    public var browser (get, never) : Signal1ReadOnly<BrowserState>;
    public var settingSelection (get, never) : Signal1ReadOnly<SettingSelection>;
    public var grid (get, never) : GridReadOnly;
    public var buttons (get, never) : ButtonsReadOnly;

    private inline function get_dials() : DialsReadOnly
    {
        return this.dials;
    }

    private inline function get_input() : Signal1ReadOnly<InputState>
    {
        return this.input;
    }

    private inline function get_browser() : Signal1ReadOnly<BrowserState>
    {
        return this.browser;
    }

    private inline function get_settingSelection() : Signal1ReadOnly<SettingSelection>
    {
        return this.settingSelection;
    }

    private inline function get_grid() : GridReadOnly
    {
        return this.grid;
    }

    private inline function get_buttons() : ButtonsReadOnly
    {
        return this.buttons;
    }
}