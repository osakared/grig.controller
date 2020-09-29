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

package fire.input.button;

import renoise.Renoise;
import fire.util.Math;
import fire.util.Modifiers;
import fire.input.button.ButtonType;

class GridRight implements Button
{
    public var type : ButtonType;

    public function new(type :ButtonType) : Void
    {
        this.type = type;
    }

    public function down(modifiers :Modifiers) : Void
    {
    }

    public function up(modifiers :Modifiers) : Void
    {
        switch Renoise.song().selectedSubColumnType {
            case NOTE:
            case INSTRUMENT:
            case VOLUME:
            case EFFECT_NUMBER:
            case EFFECT_AMOUNT:
            case _:
        }
        // Renoise.app().showStatus(Std.string(Renoise.song().selectedNoteColumnIndex));
        // modifiers.gridIndex = Math.clamp(modifiers.gridIndex + 1, 0, 6);
    }
}