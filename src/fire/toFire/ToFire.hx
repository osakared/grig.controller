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

package fire.toFire;

import fire.toFire.button.Buttons;
import fire.util.Signal1;
import fire.util.Cursor;
import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.Display;
import fire.toFire.button.ButtonLights;
import fire.toFire.Grid;
import renoise.LineChangeObserver;
import fire.fromFire.ControllerStateReadOnly;
import fire.toFire.view.display.Tracker;
import fire.toFire.view.grid.Step;
import fire.toFire.view.grid.Piano;
using lua.PairTools;

class ToFire
{
    public function new(outputDevice :MidiOutputDevice, controllerState :ControllerStateReadOnly, gridIndex :Signal1<Cursor>) : Void
    {
        _outputDevice = outputDevice;
        _gridIndex = gridIndex;
        _display = new Display();
        _pads = new Grid(_outputDevice);
        var buttonLights = new ButtonLights();
        _transport = new Buttons(buttonLights, controllerState, _outputDevice);
        this.initializeListeners(controllerState);
        makeDrawCalls(controllerState);
    }

    private function initializeListeners(controllerState :ControllerStateReadOnly) : Void
    {
        var lineObserver = new LineChangeObserver();
        lineObserver.register(0, makeDrawCalls.bind(controllerState));
        _gridIndex.addListener((_) -> {
            makeDrawCalls(controllerState);
        });
        controllerState.input.addListener((_) -> {
            makeDrawCalls(controllerState);
        });
        controllerState.grid.change.addListener(makeDrawCalls.bind(controllerState));
        controllerState.dials.change.addListener(makeDrawCalls.bind(controllerState));
        controllerState.buttons.change.addListener(makeDrawCalls.bind(controllerState));
        Renoise.song().selectedPatternTrackObservable.addNotifier(makeDrawCalls.bind(controllerState));
    }

    private function makeDrawCalls(controllerState :ControllerStateReadOnly) : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0 || Renoise.song().selectedEffectColumnIndex != 0) {
            var transport = Renoise.song().transport;
            var padIndex =  transport.editMode
                ? transport.editPos.line
                : transport.playbackPos.line;
            drawPads(controllerState, padIndex);
            drawDisplay(controllerState, padIndex);
        }
    }

    private function drawDisplay(controllerState :ControllerStateReadOnly, padIndex :Int) : Void
    {
        switch controllerState.input.value {
            case STEP:
                Tracker.draw(_outputDevice, _display, _gridIndex.value, padIndex);
            case NOTE:
                Tracker.draw(_outputDevice, _display, _gridIndex.value, padIndex);
            case DRUM:
                Tracker.draw(_outputDevice, _display, _gridIndex.value, padIndex);
            case PERFORM:
                Tracker.draw(_outputDevice, _display, _gridIndex.value, padIndex);
        }
    }  

    private function drawPads(controllerState :ControllerStateReadOnly, padIndex :Int) : Void
    {
        switch controllerState.input.value {
            case STEP:
                Step.draw(_outputDevice, _pads, padIndex);
            case NOTE:
                Piano.draw(_outputDevice, _pads, controllerState);
            case DRUM:
            case PERFORM:
        }
    }  

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _pads :Grid;
    private var _transport :Buttons;
    private var _gridIndex :Signal1<Cursor>;
}