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

package fire.output;

import renoise.song.EffectColumn;
import haxe.zip.Reader;
import fire.util.ActiveKeys;
import fire.util.RenoiseUtil;
import renoise.Renoise;
import renoise.song.NoteColumn;
import renoise.midi.Midi.MidiOutputDevice;
import fire.output.Display;
import fire.output.button.ButtonLights;
import fire.output.Grid as OutputGrid;
import renoise.LineChaneObserver;

class Transport
{
    public function new(buttons :ButtonLights, outputDevice :MidiOutputDevice) : Void
    {
        _buttons = buttons;
        _outputDevice = outputDevice;
        resetLights();
        initializeListeners();
    }

    private function resetLights() : Void
    {
        handlePlaying();
    }

    private function handlePlaying() : Void
    {
        if(Renoise.song().transport.playing) {
            _buttons.play.send(_outputDevice, 3);
        }
        else {
            _buttons.play.send(_outputDevice, 0);
        }
    }

    private function initializeListeners() : Void
    {
        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlaying();
        });
    }

    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
}