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

package fire.toFire.button;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.button.ButtonLights;
import fire.fromFire.ControllerStateReadOnly;

class Buttons
{
    public function new(buttons :ButtonLights, controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice) : Void
    {
        _buttons = buttons;
        _outputDevice = outputDevice;
        _controllerState = controllerState;
        resetLights();
        initializeListeners();
    }

    private function resetLights() : Void
    {
        handlePatternUp();
        handlePatternDown();
        handleBrowser();
        handleGridLeft();
        handleGridRight();
        handleMuteSolo1();
        handleMuteSolo2();
        handleMuteSolo3();
        handleMuteSolo4();
        handleThingThing();
        handleShift();
        handleAlt();
        handlePatternSong();
        handlePlay();
        handleStop();
        handleRecord();
    }

    private function handlePatternUp() : Void
    {
        var isDown = _controllerState.patternUp.value;
        if(isDown) {
            _buttons.patternUp.send(_outputDevice, 1);
        }
        else {
            _buttons.patternUp.send(_outputDevice, 0);
        }
    }

    private function handlePatternDown() : Void
    {
        var isDown = _controllerState.patternDown.value;
        if(isDown) {
            _buttons.patternDown.send(_outputDevice, 1);
        }
        else {
            _buttons.patternDown.send(_outputDevice, 0);
        }
    }

    private function handleBrowser() : Void
    {
        var isDown = _controllerState.browser.value;
        if(isDown) {
            _buttons.browser.send(_outputDevice, 1);
        }
        else {
            _buttons.browser.send(_outputDevice, 0);
        }
    }

    private function handleGridLeft() : Void
    {
        var isDown = _controllerState.gridLeft.value;
        if(isDown) {
            _buttons.gridLeft.send(_outputDevice, 1);
        }
        else {
            _buttons.gridLeft.send(_outputDevice, 0);
        }
    }

    private function handleGridRight() : Void
    {
        var isDown = _controllerState.gridRight.value;
        if(isDown) {
            _buttons.gridRight.send(_outputDevice, 1);
        }
        else {
            _buttons.gridRight.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo1() : Void
    {
        var isDown = _controllerState.muteSolo1.value;
        if(isDown) {
            _buttons.muteSolo1.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo1.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo2() : Void
    {
        var isDown = _controllerState.muteSolo2.value;
        if(isDown) {
            _buttons.muteSolo2.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo2.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo3() : Void
    {
        var isDown = _controllerState.muteSolo3.value;
        if(isDown) {
            _buttons.muteSolo3.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo3.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo4() : Void
    {
        var isDown = _controllerState.muteSolo4.value;
        if(isDown) {
            _buttons.muteSolo4.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo4.send(_outputDevice, 0);
        }
    }

    private function handleThingThing() : Void
    {
        if(_controllerState.step.value) {
            _buttons.step.send(_outputDevice, 2);
            _controllerState.inputUnsafe.value = STEP;
        }
        else {
            switch _controllerState.input.value {
                case STEP:
                    _buttons.step.send(_outputDevice, 4);
                case _:
                    _buttons.step.send(_outputDevice, 0);
            }
        }

        if(_controllerState.note.value) {
            _buttons.note.send(_outputDevice, 2);
            _controllerState.inputUnsafe.value = NOTE;
        }
        else {
            switch _controllerState.input.value {
                case NOTE:
                    _buttons.note.send(_outputDevice, 4);
                case _:
                    _buttons.note.send(_outputDevice, 0);
            }
        }

        if(_controllerState.drum.value) {
            _buttons.drum.send(_outputDevice, 2);
            _controllerState.inputUnsafe.value = DRUM;
        }
        else {
            switch _controllerState.input.value {
                case DRUM:
                    _buttons.drum.send(_outputDevice, 4);
                case _:
                    _buttons.drum.send(_outputDevice, 0);
            }
        }

        if(_controllerState.perform.value) {
            _buttons.perform.send(_outputDevice, 2);
            _controllerState.inputUnsafe.value = PERFORM;
        }
        else {
            switch _controllerState.input.value {
                case PERFORM:
                    _buttons.perform.send(_outputDevice, 4);
                case _:
                    _buttons.perform.send(_outputDevice, 0);
            }
        }
    }

    private function handleShift() : Void
    {
        var isDown = _controllerState.shift.value;
        if(isDown) {
            _buttons.shift.send(_outputDevice, 1);
        }
        else {
            _buttons.shift.send(_outputDevice, 0);
        }
    }

    private function handleAlt() : Void
    {
        var isDown = _controllerState.alt.value;
        if(isDown) {
            _buttons.alt.send(_outputDevice, 1);
        }
        else {
            _buttons.alt.send(_outputDevice, 0);
        }
    }

    private function handlePatternSong() : Void
    {
        var isDown = _controllerState.patternSong.value;
        if(isDown) {
            _buttons.patternSong.send(_outputDevice, 1);
        }
        else {
            _buttons.patternSong.send(_outputDevice, 0);
        }
    }

    private function handlePlay() : Void
    {
        var isDown = _controllerState.play.value;
        if(isDown) {
            _buttons.play.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.playing) {
                _buttons.play.send(_outputDevice, 3);
            }
            else {
                _buttons.play.send(_outputDevice, 0);
            }
        }
    }

    private function handleStop() : Void
    {
        var isDown = _controllerState.stop.value;
        if(isDown) {
            _buttons.stop.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.playing) {
                _buttons.stop.send(_outputDevice, 0);
            }
            else {
                _buttons.stop.send(_outputDevice, 2);
            }
        }
    }

    private function handleRecord() : Void
    {
        var isDown = _controllerState.record.value;
        if(isDown) {
            _buttons.record.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.editMode) {
                _buttons.record.send(_outputDevice, 3);
            }
            else {
                _buttons.record.send(_outputDevice, 0);
            }
        }
    }

    private function initializeListeners() : Void
    {
        _controllerState.patternUp.addListener((_, _) -> handlePatternUp());
        _controllerState.patternDown.addListener((_, _) -> handlePatternDown());
        _controllerState.browser.addListener((_, _) -> handleBrowser());
        _controllerState.gridLeft.addListener((_, _) -> handleGridLeft());
        _controllerState.gridRight.addListener((_, _) -> handleGridRight());
        _controllerState.muteSolo1.addListener((_, _) -> handleMuteSolo1());
        _controllerState.muteSolo2.addListener((_, _) -> handleMuteSolo2());
        _controllerState.muteSolo3.addListener((_, _) -> handleMuteSolo3());
        _controllerState.muteSolo4.addListener((_, _) -> handleMuteSolo4());
        _controllerState.step.addListener((_, _) -> handleThingThing());
        _controllerState.note.addListener((_, _) -> handleThingThing());
        _controllerState.drum.addListener((_, _) -> handleThingThing());
        _controllerState.perform.addListener((_, _) -> handleThingThing());
        _controllerState.shift.addListener((_, _) -> handleShift());
        _controllerState.alt.addListener((_, _) -> handleAlt());
        _controllerState.patternSong.addListener((_, _) -> handlePatternSong());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlay();
        });
        _controllerState.play.addListener((_, _) -> handlePlay());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handleStop();
        });
        _controllerState.stop.addListener((_, _) -> handleStop());

        Renoise.song().transport.editModeObservable.addNotifier(() -> {
            handleRecord();
        });
        _controllerState.record.addListener((_, _) -> handleRecord());
    }

    private var _controllerState :ControllerStateReadOnly;
    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
}