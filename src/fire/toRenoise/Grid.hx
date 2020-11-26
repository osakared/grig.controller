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

import lua.TableTools;
import fire.util.State.StateReadOnly;
import fire.util.RenoiseUtil;
import renoise.Renoise;
import lua.Table;

class Grid
{
    public function new() : Void
    {
    }

    public function down(state :StateReadOnly, pad :Int) : Void
    {
        switch state.input.value {
            case STEP:
                RenoiseUtil.setLine(pad + 1, 64);
            case NOTE: {
                var instr = Renoise.song().selectedInstrumentIndex;
                var track = Renoise.song().selectedTrackIndex;
                var note = 30;
                var velocity = 0x80;
                var osc_vars = Table.create();
                Table.insert(osc_vars, {tag: "i",value: instr});
                Table.insert(osc_vars, {tag: "i",value: track});
                Table.insert(osc_vars, {tag: "i",value: note});
                Table.insert(osc_vars, {tag: "i",value: velocity});
                var header = "/renoise/trigger/note_on";
                var osc_msg = renoise.Osc.createMessage(header,osc_vars);
                // Renoise.Osc.Message(Table.create([0,1]));
            }
                // Renoise.song().instrument(1)
            case DRUM:
            case PERFORM:
        }
    }
}