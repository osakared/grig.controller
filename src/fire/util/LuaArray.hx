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

package fire.util;

import lua.Table;

abstract LuaArray<T>(Table<Int, T>) to Table<Int, T>
{
    public var length (get, never) : Int;

    inline public function new(array :Array<T>) : Void
    {
        this = Table.create(array);
    }

    @:arrayAccess
    public inline function get(key :Int) {
        return this[key];
    }

    @:arrayAccess
    public inline function arrayWrite(k :Int, v :T) : T 
    {
        this[k] = v;
        return v;
    }

    public inline function push(item :T) : Void
    {
        untyped _hx_table_push(this, item);
    }

    public inline function clear() : Void
    {
        untyped _hx_table_clear(this);
    }

    private inline function get_length() : Int
    {
        return untyped _hx_length(this);
    }
}