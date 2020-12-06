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
import renoise.Socket;
import renoise.Socket.SocketClient;
import renoise.Renoise;
import renoise.Osc.OscArgs;

class SoftKeys
{
    public function new() : Void
    {
        var host = "localhost";
        var port = 8000;
        _client = Socket.createClient(host, port, UDP);
    }

    public function playNote(isOn :Bool, note :Int, renoiseState :RenoiseState) : Void
    {
        var velocity = 127;

        var oscVa = OscArgs.create();
        oscVa.addTagValue("i", renoiseState.instrumentIndex);
        oscVa.addTagValue("i", renoiseState.trackIndex);
        oscVa.addTagValue("i", note);
        if(isOn) {
            oscVa.addTagValue("i", velocity);
        }
        var header = isOn
            ? "/renoise/trigger/note_on"
            : "/renoise/trigger/note_off";
        var oscMsg = renoise.Osc.createMessage(header,oscVa);
        _client.send(oscMsg);
    }

    private var _client :SocketClient;
}