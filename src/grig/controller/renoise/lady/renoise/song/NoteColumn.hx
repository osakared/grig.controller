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

extern class NoteColumn
{
    public static inline var NOTE_OFF = 120;
    public static inline var NOTE_EMPTY = 121;
    public static inline var MIDDLE_C = 60;

    /**
     * True, when all note column properties are empty.
     * @return Bool
     */
    @:native("is_empty")
    public var isEmpty : Bool;
 
    /**
     * True, when this column is selected in the pattern or phrase 
     * edito current pattern.
     * @return Bool
     */
    @:native("is_selected")
    public var isSelected : Bool;

    @:native("note_value")
    public var noteValue : Int;

    @:native("note_string")
    public var noteString : String;

    @:native("instrument_value")
    public var instrumentValue : Int;

    @:native("instrument_string")
    public var instrumentString : String;

    @:native("volume_value")
    public var volumeValue : Int;

    @:native("volume_string")
    public var volumeString : String;

    @:native("panning_value")
    public var panningValue : Int;

    @:native("panning_string")
    public var panningString : String;

    @:native("delay_value")
    public var delayValue : Int;

    @:native("delay_string")
    public var delayString : String;

    @:native("effect_number_value")
    public var effectNumberValue : Int;

    @:native("effect_number_string")
    public var effectNumberString : String;

    @:native("effect_amount_value")
    public var effectAmountValue : Int;

    @:native("effect_amount_string")
    public var effectAmountString : String;

    /**
     * Clear the note column.
     */
    public function clear() : Void;

    /**
     * Copy the column's content from another column.
     * @param other 
     */
    @:native("copy_from")
    public function copy_from(other :NoteColumn) : Void;
}