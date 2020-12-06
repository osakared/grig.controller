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

package fire.fromFire.button;

import fire.util.Signal0ReadOnly;
import fire.util.Signal1ReadOnly;

abstract ButtonsReadOnly(Buttons) from Buttons
{
    public var hasDown (get, never) : Bool;
    public var fire (get, never) : Signal0ReadOnly;
    public var onUp (get, never) : Signal1ReadOnly<Null<ButtonType>>;
    public var onDown (get, never) : Signal1ReadOnly<Null<ButtonType>>;

    public inline function isDown(button :ButtonType) : Bool
    {
        return this.isDown(button);
    }

    public inline function isButton(value :ButtonType) : Bool
    {
        return this.isButton(value);
    }

    public inline function iterator() : Iterator<ButtonType>
    {
        return this.iterator();
    }

    private inline function get_hasDown() : Bool
    {
        return this.hasDown;
    }

    private inline function get_fire() : Signal0ReadOnly
    {
        return this.fire;
    }

    private inline function get_onUp() : Signal1ReadOnly<Null<ButtonType>>
    {
        return this.onUp;
    }

    private inline function get_onDown() : Signal1ReadOnly<Null<ButtonType>>
    {
        return this.onDown;
    }
}