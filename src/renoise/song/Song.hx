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

extern class Song
{

    public var file_name :String;

    public var artist : String;
    public var artist_observable : Observable;

    public var name : String;
    public var name_observable : Observable;

    public var rendering (default, null) : Bool;

    public var rendering_progress (default, null) : Float;

    public var transport (default, null) : Transport;

    public var sequencer (default, null) : PatternSequencer;

    public var pattern_iterator (default, null) : PatternIterator;

    public var sequencer_track_count (default, null) : Int;

    public var send_track_count (default, null) : Int; //left off here!



    @:native("selected_line")
    public var selectedLine : PatternLine;

    /**
     * The currently edited pattern. Never nil.
     */
    @:native("selected_pattern")
    public var selectedPattern : Pattern;

    /**
     * Observed currently edited pattern. Never nil.
     */
    @:native("selected_pattern_observable")
    public var selectedPatternObservable : Observable;

    /**
     * The currently edited pattern track object. Never nil. and selected_track_observable for notifications.
     */
    @:native("selected_pattern_track")
    public var selectedPatternTrack : PatternTrack;
 
    /**
     * Observed currently edited pattern track object. Never nil. and selected_track_observable for notifications.
     */
    @:native("selected_pattern_track_observable")
    public var selectedPatternTrackObservable : Observable;

    /**
     * Test if something in the song can be undone.
     */
    @:native("can_undo")
    public function canUndo() :Bool;

    /**
     * Undo the last performed action. Will do nothing if nothing can be undone.
     */
    public function undo() :Void;

    /**
     * Test if something in the song can be redone.
     */
    @:native("can_redo")
    public function canRedo() :Bool;
 
    /**
     * Redo a previously undo action. Will do nothing if nothing can be redone.
     */
    public function redo() :Void;

    //BELOW NEEDS DOCUMENTATION AND NATIVE FUNCTION NAMES

    public function describe_undo(description :String) : Void;

    public function insert_track_at(index :Int) : Track;

    public function delete_track_at(index :Int) : Void;

    public function swap_tracks_at(a :Int, b :Int) : Void;

    public function track(index :Int) : Track;

    public function select_previous_track() : Void;

    public function select_next_track() : Void;

    public function insert_group_at(index :Int) : GroupTrack;

    public function add_track_to_group(trackIndex :Int, groupIndex :Int) : Void;

    public function remove_track_from_group(index :Int) : Void;

    public function delete_group_at(index :Int) : Void;

    public function insert_instrument_at(index :Int) : Instrument;

    public function delete_instrument_at(index :Int) : Void;

    public function swap_instruments_at(a :Int, b :Int) : Void;

    public function instrument(index :Int) : Instrument;

    public function capture_instrument_from_pattern() : Void;

    public function capture_nearest_instrument_from_pattern() : Void;

    public function pattern(index :Int) : Pattern;

    public function cancel_rendering() : Void;

    public function render(vals :Dynamic) : Dynamic;

    public function load_midi_mappings(filename :String) : Dynamic;

    public function save_midi_mappings(filename :String) : Dynamic;

    public function clear_midi_mappings() : Void;



}