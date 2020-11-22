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

package fire.fromFire.button;

import fire.util.Signal;
import fire.util.Cursor;

class Button
{
    public var type (default, null) : ButtonType;
    public var isDown (default, null) : Signal<Bool>;
    public var gridIndex (default, null) : Signal<Cursor>;

    public function new(type :ButtonType, gridIndex :Signal<Cursor>) : Void
    {
        this.type = type;
        this.gridIndex = gridIndex;
        this.isDown = new Signal(false);
        this.isDown.addListener((_isDown) -> {
            if(_isDown) {
                this.onDown();
            }
            else {
                this.onUp();
            }
        });
    }

    public function down(buttons :Buttons) : Void
    {
        this.isDown.value = false;
    }

    public function up(buttons :Buttons) : Void
    {
        this.isDown.value = true;
    }

    public function onUp() : Void
    {
    }

    public function onDown() : Void
    {
    }
}