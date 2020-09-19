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

typedef LineNotifier = {pattern :Dynamic, track :Dynamic, line :Dynamic} -> Void;

extern class Pattern
{
    @:native("is_empty")
    public var isEmpty : Bool;

    public var name :String;
    @:native("name_observable")
    public var nameObservable :Observable;

    public var number_of_lines :Int;
    @:native("number_of_lines_observable")
    public var numberOfLinesObservable :Observable;

    public var tracks :Table<Int, PatternTrack>;

    /**
     * Deletes all lines & automation.
     */
    public function clear() : Void;

    /**
     * Copy contents from other patterns, including automation, 
     * when possible.
     * @param pattern 
     */
    @:native("copy_from")
    public function copy_from(pattern :Pattern) : Void;

    /**
     * Access to a single pattern track by index. Use properties 
     * 'tracks' to iterate over all tracks and to query the track 
     * count.
     * @param index 
     * @return PatternTrack
     */
    public function track(index :Int) : PatternTrack;

    @:native("has_line_notifier")
    public function hasLineNotifier(notifier :LineNotifier) : Void;

    @:native("add_line_notifier")
    public function addLineNotifier(notifier :LineNotifier) : Void;

    @:native("remove_line_notifier")
    public function removeLineNotifier(notifier :LineNotifier) : Void;

    @:native("has_line_edited_notifier")
    public function hasLineEditedNotifier(notifier :LineNotifier) : Void;

    @:native("add_line_edited_notifier")
    public function addLineEditedNotifier(notifier :LineNotifier) : Void;

    @:native("remove_line_edited_notifier")
    public function removeLineEditedNotifier(notifier :LineNotifier) : Void;
}