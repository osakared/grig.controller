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

import fire.util.PadNote;
import renoise.Socket;
import renoise.Socket.SocketClient;
import fire.util.State.StateReadOnly;
import fire.util.RenoiseUtil;
import renoise.Renoise;
import renoise.Osc.OscArgs;

class Grid
{
    public function new() : Void
    {
        var host = "localhost";
        var port = 8000;
        _client = Socket.createClient(host, port, UDP);
    }

    public function down(state :StateReadOnly, pad :Int) : Void
    {
        switch state.input.value {
            case STEP:
                RenoiseUtil.setLine(pad + 1, 64);
            case NOTE: {
                var note = PadNote.getNote(pad);
                Renoise.app().showStatus("Down");
                if(note != -1) {
                    var instr = Renoise.song().selectedInstrumentIndex;
                    var track = Renoise.song().selectedTrackIndex;
                    var velocity = 127;

                    var oscVars = OscArgs.create();
                    oscVars.addTagValue("i", instr);
                    oscVars.addTagValue("i", track);
                    oscVars.addTagValue("i", note);
                    oscVars.addTagValue("i", velocity);
                    var header = "/renoise/trigger/note_on";
                    var oscMsg = renoise.Osc.createMessage(header,oscVars);
                    _client.send(oscMsg);
                }
            }
            case DRUM:
            case PERFORM:
        }
    }

    public function up(state :StateReadOnly, pad :Int) : Void
    {
        Renoise.app().showStatus(Std.string(pad));
        switch state.input.value {
            case STEP:
            case NOTE: {
                var note = PadNote.getNote(pad);
                if(note != -1) {
                    var instr = Renoise.song().selectedInstrumentIndex;
                    var track = Renoise.song().selectedTrackIndex;

                    var oscVars = OscArgs.create();
                    oscVars.addTagValue("i", instr);
                    oscVars.addTagValue("i", track);
                    oscVars.addTagValue("i", note);
                    var header = "/renoise/trigger/note_off";
                    var oscMsg = renoise.Osc.createMessage(header,oscVars);
                    _client.send(oscMsg);
                }
            }
            case DRUM:
            case PERFORM:
        }
    }

    private var _client :SocketClient;
}

