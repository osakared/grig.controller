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

import lua.Os;
import lady.renoise.Socket;
import lady.renoise.Socket.SocketClient;
import lady.renoise.Renoise;
import lady.renoise.Osc.OscArgs;

class SoftKeys
{
    public function new() : Void
    {
        var host = "localhost";
        var port = 8000;
        _client = Socket.createClient(host, port, UDP);
        _lastTime = Os.time();

        Renoise.tool().appIdleObservable.addNotifier(() -> {
            var time = Os.time();
            var elapsed = time - _lastTime;
            if(elapsed > 1) {
                disposeLast();
            }
        });
    }

    public function sampleNote(note :Int, instrumentIndex :Int, trackIndex :Int) : Void
    {
        this.disposeLast();
        _lastTime = Os.time();

        this.playNote(true, note, instrumentIndex, trackIndex);
        _lastSampleDisposer = () -> {
            this.playNote(false, note, instrumentIndex, trackIndex);
        }
    }

    public function playNote(isOn :Bool, note :Int, instrumentIndex :Int, trackIndex :Int) : Void
    {
        var velocity = 127;

        var oscVa = OscArgs.create();
        oscVa.addTagValue("i", instrumentIndex);
        oscVa.addTagValue("i", trackIndex);
        oscVa.addTagValue("i", note);
        if(isOn) {
            oscVa.addTagValue("i", velocity);
        }
        var header = isOn
            ? "/renoise/trigger/note_on"
            : "/renoise/trigger/note_off";
        var oscMsg = lady.renoise.Osc.createMessage(header,oscVa);
        _client.send(oscMsg);
    }

    private function disposeLast() : Void
    {
        if(_lastSampleDisposer != null) {
            _lastSampleDisposer();
            _lastSampleDisposer = null;
        }
    }

    private var _client :SocketClient;
    private var _lastSampleDisposer : Null<Void -> Void> = null;
    private var _lastTime : lua.Time;
}