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

extern class PatternTrackAutomation
{
    /**
     * Removes all points from the automation. Will not delete the automation 
     * from tracks[]:automation, instead the resulting automation will not do 
     * anything at all.
     */
    public function clear() : Void;
    
    /**
     * Remove all existing points in the given [from, to) time range from the automation.
     * @param from 
     * @param to 
     * @return Void
     */
    @:native("clear_range")
    public function clearRange(from :Int, to :Int) : Void;

    /**
     * Test if a point exists at the given time (in lines
     * @param time 
     * @return Bool
     */
    @:native("has_point_at")
    public function hasPointAt(time :Int) : Bool;

    /**
     * Insert a new point, or change an existing one, if a point in time already 
     * exists.
     * @param time 
     * @param value 
     */
    public function add_point_at(time :Int, value :Int) : Void;

    /**
     * Removes a point at the given time. Point must exist.
     * @param time 
     * @return Bool
     */
    @:native("remove_point_at")
    public function removePointAt(time :Int) : Bool;
}