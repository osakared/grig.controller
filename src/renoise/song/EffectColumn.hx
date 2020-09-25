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

package renoise.song;

extern class EffectColumn
{
    @:native("is_empty")
    public var isEmpty (default, null) : Bool;

    @:native("is_selected")
    public var isSelected (default, null) : Bool;

    @:native("number_value")
    public var numberValue : Int;
    @:native("number_string")
    public var numberString : String;

    @:native("amount_value")
    public var amountValue : Int;
    @:native("amount_string")
    public var amountString : String;

    /**
     * Clear the effect column.
     */
    public function clear() : Void;

    /**
     * Copy the column's content from another column.
     * @param other 
     */
    @:native("copy_from")
    public function copyFrom(other :EffectColumn) : Void;
}