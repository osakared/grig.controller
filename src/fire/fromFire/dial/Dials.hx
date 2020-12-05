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

package fire.fromFire.dial;

import fire.util.Signal0;
import fire.util.Signal1;

class Dials
{
    public var fire (default, null) : Signal0;
    public var onLeft (default, null) : Signal1<Null<DialType>>;
    public var onRight (default, null) : Signal1<Null<DialType>>;

    public function new() : Void
    {
        this.fire = new Signal0();
        this.onLeft = new Signal1(null);
        this.onRight = new Signal1(null);
    }

    public function left(type :DialType) : Void
    {
        this.onLeft.value = type;
        this.fire.emit();
    }

    public function right(type :DialType) : Void
    {
        this.onRight.value = type;
        this.fire.emit();
    }
}