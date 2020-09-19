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

import lua.Table;

extern class PatternTrack
{
    @:native("is_alias")
    public var isAlias (default, null): Bool;

    @:native("alias_pattern_index")
    public var aliasPatternIndex : Int;
    @:native("alias_pattern_index_observable")
    public var aliasPatternIndexObservable : Observable;

    public var color : Table<Int, Int>;
    @:native("color_observable")
    public var colorObservable : Observable;

    @:native("is_empty")
    public var isEmpty (default, null): Bool;
    @:native("is_empty_observable")
    public var isEmptyObservable (default, null): Observable;

    public var lines (default, null): Table<Int, PatternLine>;

    public var automation (default, null): Table<Int, PatternTrackAutomation>;
    @:native("automation_observable")
    public var automationObservable (default, null): Observable;


    /**
     * Deletes all lines & automation.
     */
    public function clear() : Void;

    /**
     * Copy contents from other pattern tracks, including automation when possible.
     * 
     * @param patternTrack 
     */
    @:native("copy_from")
    public function copyFrom(patternTrack :PatternTrack) : Void;

    /**
     * Access to a single line by index. Line must be [1-MAX_NUMBER_OF_LINES]). This 
     * is a !lot! more efficient than calling the property: lines[index] to randomly 
     * access lines.
     * 
     * @param index 
     * @return PatternLine
     */
    public function line(index :Int) : PatternLine;

    /**
     * Get a specific line range (index must be [1-Pattern.MAX_NUMBER_OF_LINES])
     * 
     * @param from 
     * @param to 
     * @return Table<Int, PatternLine>
     */
    @:native("lines_in_range")
    public function linesInRange(from :Int, to :Int) : Table<Int, PatternLine>;

    /**
     * Returns the automation for the given device parameter or nil when there is none.
     * 
     * @param parameter 
     * @return PatternTrackAutomation
     */
    @:native("find_automation")
    public function findAutomation(parameter :Dynamic) : PatternTrackAutomation;

    /**
     * Creates a new automation for the given device parameter. Fires an error when an 
     * automation for the given parameter already exists. Returns the newly created 
     * automation. Passed parameter must be automatable, which can be tested with 
     * 'parameter.is_automatable'.
     * 
     * @param parameter 
     * @return PatternTrackAutomation
     */
    @:native("create_automation")
    public function createAutomation(parameter :Dynamic) : PatternTrackAutomation;

    /**
     * Remove an existing automation the given device parameter. Automation must exist.
     * 
     * @param parameter 
     */
    @:native("delete_automation")
    public function deleteAutomation(parameter :Dynamic) : Void;
}