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

package lady.renoise.song;

import lady.LArray;

extern class PatternLine
{
    @:native("is_empty")
    public var isEmpty : Bool;

    @:native("note_columns")
    public var noteColumns : LArray<NoteColumn>;

    @:native("effect_columns")
    public var effectColumns : LArray<EffectColumn>;

    /**
     * Clear all note and effect columns.
     */
    public function clear() : Void;

    /**
     * Copy contents from other_line, trashing column content.
     * @param other 
     */
    @:native("copy_from")
    public function copyFrom(other :PatternLine) : Void;

    /**
     * Access to a single note column by index. Use properties 'note_columns' 
     * to iterate over all note columns and to query the note_column count. 
     * This is a !lot! more efficient than calling the property: 
     * note_columns[index] to randomly access columns. When iterating over 
     * all columns, use pai(note_columns).
     * @param index 
     * @return NoteColumn
     */
    @:native("note_column")
    public function noteColumn(index :Int) : NoteColumn;

    /**
     * Access to a single effect column by index. Use properties 
     * 'effect_columns' to iterate over all effect columns and to query the 
     * effect_column count. This is a !lot! more efficient than calling the 
     * property: effect_columns[index] to randomly access columns. When 
     * iterating over all columns, use pai(effect_columns).
     * @param index 
     * @return EffectColumn
     */
    @:native("effect_column")
    public function effectColumn(index :Int) : EffectColumn;
}