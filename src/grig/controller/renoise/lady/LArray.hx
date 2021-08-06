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

package lady;

import lua.Table;
import lua.PairTools;

abstract LArray<T>(Table<Int, T>)
{
    public var length (get, never) : Int;

    public inline function new(?arr:Null<Array<T>>) : Void
    {
        this = Table.create(arr);
    }

    public inline function push(item :T) : Void
    {
        Table.insert(this, item);
    }

    public function pop() : Null<T>
    {
        var index :Int = untyped _hx_length(this);
        var item = this[index];
        Table.remove(this);
        return item;
    }

    public inline function ipairsEach(func:(Int, T) -> Void) : Void
    {
        PairTools.ipairsEach(this, func);
    }

    @:arrayAccess
    private inline function get(key :Int) {
        return this[key];
    }

    @:arrayAccess
    private inline function arrayWrite(k :Int, v :T) : T 
    {
        this[k] = v;
        return v;
    }

    private inline function get_length() : Int
    {
        return untyped _hx_length(this);
    }
}