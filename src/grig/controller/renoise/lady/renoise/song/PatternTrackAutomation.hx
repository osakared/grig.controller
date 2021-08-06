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

import lady.renoise.song.AutomationPlayMode;
import lady.LArray;

extern class PatternTrackAutomation
{

    /**
     * Destination device. Can in some rare circumstances be nil, i.e. when a 
     * device or track is about to be deleted.
     */
    @:native("dest_device")
    public var destDevice : AudioDevice;

    /**
     * Destination device's parameter. Can in some rare circumstances be nil, 
     * i.e. when a device or track is about to be deleted.
     */
    @:native("dest_parameter")
    public var destParameter : DeviceParameter;

    /**
     * play-mode (interpolation mode).
     */
    public var playmode : AutomationPlayMode;

    @:native("playmode_observable")
    public var playmodeObservable : Observable;

    /**
     * Max length (time in lines) of the automation. Will always fit the 
     * patterns length.
     */
    public var length : Int;

    /**
     * Selection range as visible in the automation editor. always valid. 
     * returns the automation range no selection is present in the UI.
     */
    @:native("selection_start")
    public var selectionStart : Int;

    @:native("selection_start_observable")
    public var selectionStartObservable : Observable;

    @:native("selection_end")
    public var selectionEnd : Int;
    
    @:native("selection_end_observable")
    public var selectionEndObservable : Observable;

    /**
     * Get or set selection range. when setting an empty table, the existing 
     * selection, if any, will be cleared.
     */
    @:native("selection_range")
    public var selectionRange : LArray<Int>;

    @:native("selection_range_observable")
    public var selectionRangeObservable : Observable;

    /**
     * Get all points of the automation. When setting a new list of points, 
     * items may be unsorted by time, but there may not be multiple points for 
     * the same time. Returns a copy of the list, so changing points[1].value 
     * will not do anything. Instead, change them via points = { something } 
     * instead.
     */
    public var points : LArray<Int>;

    @:native("points_observable")
    public var pointsObservable : Observable;

    /**
     * An automation point's time in pattern lines.
     */
    public var time : Int;

    /**
     * An automation point's value [0-1.0]
     */
    public var value : Float;

    /**
     * An envelope point's scaling (used in 'lines' playback mode only - 0.0 is 
     * linear).
     */
    public var scaling : Float;

    /**
     * Removes all points from the automation. Will not delete the automation 
     * from tracks[]:automation, instead the resulting automation will not do 
     * anything at all.
     */
    public function clear() : Void;
    
    /**
     * Remove all existing points in the given [from, to) time range from the 
     * automation.
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