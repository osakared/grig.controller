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
    public var browser (default, null):Signal1<BrowserState>;
    public var settingSelection (default, null):Signal1<SettingSelection>;
    public var grid (default, null):Grid;
    public var buttons (default, null):Buttons;

    public function new() {
        this.dials = new Dials();
        this.input = new Signal1(STEP);
        this.browser = new Signal1(SEQ);
        this.settingSelection = new Signal1(EDIT_STEP);
        this.grid = new Grid();
        this.buttons = new Buttons();
        initInput();
    }

    private function initInput() : Void
    {
        this.buttons.onDown.addListener(type -> {
            handleButtonDown(type);
        });
        this.dials.onLeft.addListener((to) -> {
            switch to {
                case SELECT:
                    handleSelect(true);
                case _:
            }
        });
        this.dials.onRight.addListener((to) -> {
            switch to {
                case SELECT:
                    handleSelect(false);
                case _:
            }
        });
    }

    private function handleSelect(isLeft :Bool) : Void
    {
        if(this.buttons.isDown(ALT)) return;
        switch this.browser.value {
            case SETTINGS: {
                switch [this.settingSelection.value, isLeft] {
                    case [EDIT_STEP, true]:
                    case [BPM, true]: 
                        this.settingSelection.value = EDIT_STEP;
                    case [EDIT_STEP, false]:
                        this.settingSelection.value = BPM;
                    case [BPM, false]:
                }
            }
            case _:
        }
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
            case BROWSER:
                switch this.browser.value {
                    case SEQ:
                        this.browser.value = INST;
                    case INST:
                        this.browser.value = SETTINGS;
                    case SETTINGS:
                        this.browser.value = SEQ;
                }
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

enum BrowserState
{
    SEQ;
    INST;
    SETTINGS;
}

enum SettingSelection
{
    EDIT_STEP;
    BPM;
}