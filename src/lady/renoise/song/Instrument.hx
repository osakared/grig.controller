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

extern class Instrument
{
    /**
     * Instrument's name.
     */
    public var name :String;

    @:native("name_observable")
    public var nameObservable :Observable;

    /**
     * Global trigger options (quantization and scaling options). See renoise.InstrumentTriggerOptions for more info.
     */
    @:native("trigger_options")
    public var triggerOptions : InstrumentTriggerOptions;

    /**
     * Reset, clear all settings and all samples.
     */
    public function clear() : Void;

    /**
     * Copy all settings from the other instrument, including all samples.
     * @param other 
     */
    @:native("copy_from")
    public function copyFrom(other :Instrument) : Void;

    /**
     * Access a single macro by index [1-NUMBER_OF_MACROS]. See also property 'macros'.
     * @param index 
     * @return InstrumentMacro
     */
    @:native("macro_")
    public function macro_(index :Int) : InstrumentMacro;
}