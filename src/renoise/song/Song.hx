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

package renoise.song;

import lua.Table;
import renoise.ds.ReadOnlyTableArray;

extern class Song
{
    public static var MAX_NUMBER_OF_INSTRUMENTS : Int;

    /**
     * When the song is loaded from or saved to a file, the absolute path and 
     * name to the XRNS file is returned. Otherwise, an empty string is returned.
     */
    @:native("file_name")
    public var fileName (default, null) : String;

    /**
     * Song Comments Note: All property tables of basic types in the API are 
     * temporary copies. In other words renoise.song().comments = 
     * { "Hello", "World" } will work, renoise.song().comments[1] = "Hello"; 
     * renoise.song().comments[2] = "World" will not work.
     */
    public var artist : String;

    @:native("artist_observable")
    public var artistObservable (default, null) : Observable;

    /**
     * Song Comments Note: All property tables of basic types in the API are 
     * temporary copies. In other words renoise.song().comments = 
     * { "Hello", "World" } will work, renoise.song().comments[1] = "Hello"; 
     * renoise.song().comments[2] = "World" will not work.
     */
    public var name : String;

    @:native("name_observable")
    public var nameObservable (default, null) : Observable;

    /**
     * See renoise.song():render(). Returns true while rendering is in progress.
     */
    public var rendering (default, null) : Bool;

    /**
     * See renoise.song():render(). Returns the current render progress amount.
     */
    @:native("rendering_progress")
    public var renderingProgress (default, null) : Float;

    /**
     * See renoise.Transport for more info.
     */
    public var transport (default, null) : Transport;

    /**
     * See renoise.PatternSequencer for more info.
     */
    public var sequencer (default, null) : PatternSequencer;

    /**
     * See renoise.PatternIterator for more info.
     */
    @:native("pattern_iterator")
    public var patternIterator (default, null) : PatternIterator;

    /**
     * number of normal playback tracks (non-master or sends) in song.
     */
    @:native("sequencer_track_count")
    public var sequencerTrackCount (default, null) : Int;

    /**
     * number of send tracks in song.
     */
    @:native("send_track_count")
     public var sendTrackCount (default, null) : Int;

    public var instruments (default, null) : ReadOnlyTableArray<Instrument>;

    @:native("instruments_observable")
    public var instrumentsObservable (default, null) : Observable;

    public var patterns (default, null) : Table<Int, Pattern>;

    @:native("patterns_observable")
    public var patternsObservable (default, null) : Observable;

    public var tracks (default, null) : ReadOnlyTableArray<Track>;

    @:native("tracks_observable")
    public var tracksObservable (default, null) : Observable;

    /**
     * Selected in the instrument box. Never nil.
     */
    @:native("selected_instrument")
    public var selectedInstrument (default, null) : Instrument;

    @:native("selected_instrument_observable")
    public var selectedInstrumentObservable (default, null) : Observable;

    @:native("selected_instrument_index")
    public var selectedInstrumentIndex : Int;

    @:native("selected_instrument_index_observable")
    public var selectedInstrumentIndexObservable (default, null) : Observable;

    /**
     * Currently selected phrase the instrument's phrase map piano view. Can be nil.
     */
    @:native("selected_phrase")
    public var selectedPhrase (default, null) : Null<InstrumentPhrase>;

    @:native("selected_phrase_observable")
    public var selectedPhraseObservable (default, null) : Observable;

    @:native("selected_phrase_index")
    public var selectedPhraseIndex : Int;

    /**
     * Selected in the instrument's sample list. Only nil when no samples are 
     * present in the selected instrument.
     */
    @:native("selected_sample")
    public var selectedSample (default, null) : Null<Sample>;
    
    @:native("selected_sample_observable")
    public var selectedSampleObservable (default, null) : Observable;

    @:native("selected_sample_index")
    public var selectedSampleIndex : Int;

    /**
     * Selected in the instrument's modulation view. Can be nil.
     */
    @:native("selected_sample_modulation_set")
    public var selectedSampleModulationSet (default, null) : Null<SampleModulationSet>;

    @:native("selected_sample_modulation_set_observable")
    public var selectedSampleModulationSetObservable (default, null) : Observable;

    @:native("selected_sample_modulation_set_index")
    public var selectedSampleModulationSetIndex : Int;

    /**
     * Selected in the instrument's effects view. Can be nil.
     */
    @:native("selected_sample_device_chain")
    public var selectedSampleDeviceChain (default, null) : Null<SampleDeviceChain>;

    @:native("selected_sample_device_chain_observable")
    public var selectedSampleDeviceChainObservable (default, null) : Observable;

    @:native("selected_sample_device_chain_index")
    public var selectedSampleDeviceChainIndex: Int;

    /**
     * Selected in the sample effect mixer. Can be nil.
     */
    @:native("selected_sample_device")
    public var selectedSampleDevice (default, null) : Null<AudioDevice>;

    @:native("selected_sample_device_observable")
    public var selectedSampleDeviceObservable (default, null) : Observable;

    @:native("selected_sample_device_index")
    public var selectedSampleDeviceIndex : Int;

    /**
     * Selected in the pattern editor or mixer. Never nil.
     */
    @:native("selected_track")
    public var selectedTrack (default, null) : Track;

    @:native("selected_track_observable")
    public var selectedTrackObservable (default, null) : Observable;

    @:native("selected_track_index")
    public var selectedTrackIndex : Int;

    @:native("selected_track_index_observable")
    public var selectedTrackIndexObservable : Observable;

    /**
     * Selected in the track DSP chain editor. Can be nil.
     */
    @:native("selected_track_device")
    public var selectedTrackDevice (default, null) : Null<AudioDevice>;

    @:native("selected_track_device_observable")
    public var selectedTrackDeviceObservable (default, null) : Observable;

    @:native("selected_track_device_index")
    public var selectedTrackDeviceIndex : Int;

    /**
     * Selected parameter in the automation editor. Can be nil. When setting a 
     * new parameter, parameter must be automateable and must be one of the 
     * currently selected track device chain.
     */
    @:native("selected_automation_parameter")
    public var selectedAutomationParameter : Null<DeviceParameter>;

    @:native("selected_automation_parameter_observable")
    public var selectedAutomationParameterObservable (default, null) : Observable;

    /**
     * parent device of 'selected_automation_parameter'. not settable.
     */
    @:native("selected_automation_device")
    public var selectedAutomationDevice : AudioDevice;

    @:native("selected_automation_device_observable")
    public var selectedAutomationDeviceObservable (default, null) : Observable;

    /**
     * The currently edited pattern. Never nil.
     */
    @:native("selected_pattern")
    public var selectedPattern (default, null) : Pattern;

    @:native("selected_pattern_observable")
    public var selectedPatternObservable (default, null) : Observable;

    @:native("selected_pattern_index")
    public var selectedPatternIndex : Int;

    @:native("selected_pattern_index_observable")
    public var selectedPatternIndexObservable (default, null) : Observable;

    /**
     * The currently edited pattern track object. Never nil. and 
     * selected_track_observable for notifications.
     */
    @:native("selected_pattern_track")
    public var selectedPatternTrack : PatternTrack;
  
    @:native("selected_pattern_track_observable")
    public var selectedPatternTrackObservable : Observable;

    /**
     * The currently edited sequence position.
     */
    @:native("selected_sequence_index")
    public var selectedSequenceIndex : Int;

    @:native("selected_sequence_index_observable")
    public var selectedSequenceIndexObservable (default, null) : Observable;

    /**
     * The currently edited line in the edited pattern.
     */
    @:native("selected_line")
    public var selectedLine (default, null) : PatternLine;

    @:native("selected_line_index")
    public var selectedLineIndex : Int;

    /**
     * The currently edited column in the selected line in the edited 
     * sequence/pattern. Nil when an effect column is selected.
     */
    @:native("selected_note_column")
    public var selectedNoteColumn (default, null) : Null<NoteColumn>;

    @:native("selected_note_column_index")
    public var selectedNoteColumnIndex : Int;

    /**
     * The currently edited column in the selected line in the edited 
     * sequence/pattern. Nil when a note column is selected.
     */
    @:native("selected_effect_column")
    public var selectedEffectColumn (default, null) : Null<EffectColumn>;

    @:native("selected_effect_column_index")
    public var selectedEffectColumnIndex : Int;

    /**
     * The currently edited sub column type within the selected note/effect 
     * column.
     */
    @:native("selected_sub_column_type")
    public var selectedSubColumnType : SubColumn;

    @:native("selection_in_pattern")
    public var selectionInPattern : Table<Int, Selection>;

    /**
     * same as 'selection_in_pattern' but for the currently selected phrase 
     * (if any). there are no tracks in phrases, so only 'line' and 'column' 
     * fields are valid.
     */
    @:native("selection_in_phrase")
    public var selectionInPhrase : Table<Int, Selection>;

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

    /**
     * When modifying the song, Renoise will automatically add descriptions for 
     * undo/redo by looking at what fit changed (a track was inserted, a 
     * pattern line changed, and so on). When the song is changed from an action 
     * in a menu entry callback, the menu entry's label will automatically be 
     * used for the undo description. If those auto-generated names do not work 
     * for you, or you want to use something more descriptive, you can (!before 
     * changing anything in the song!) give your changes a custom undo 
     * description (like: "Generate Synth Sample")
     * 
     * @param description 
     */
    @:native("describe_undo")
    public function describeUndo(description :String) : Void;

    /**
     * Insert a new track at the given index. Inserting a track behind or at the 
     * Master Track's index will create a Send Track. Otherwise, a regular track 
     * is created.
     * 
     * @param index 
     * @return Track
     */
    @:native("insert_track_at")
    public function insertTrackAt(index :Int) : Track;

    /**
     * Delete an existing track. The Master track can not be deleted, but all 
     * Sends can. Renoise needs at least one regular track to work, thus trying 
     * to delete all regular tracks will fire an error.
     * 
     * @param index 
     */
    @:native("delete_track_at")
    public function deleteTrackAt(index :Int) : Void;

    /**
     * Swap the positions of two tracks. A Send can only be swapped with a Send 
     * track and a regular track can only be swapped with another regular track. 
     * The Master can not be swapped at all.
     * 
     * @param a 
     * @param b 
     */
    @:native("swap_tracks_at")
    public function swapTracksAt(a :Int, b :Int) : Void;

    /**
     * Access to a single track by index. Use properties 'tracks' to iterate 
     * over all tracks and to query the track count.
     * 
     * @param index 
     * @return Track
     */
    public function track(index :Int) : Track;

    /**
     * Set the selected track to prev/next relative to the current track. Takes 
     * care of skipping over hidden tracks and wrapping around at the edges.
     */
    @:native("select_previous_track")
    public function selectPreviousTrack() : Void;

    /**
     * Set the selected track to prev/next relative to the current track. Takes 
     * care of skipping over hidden tracks and wrapping around at the edges.
     */
    @:native("select_next_track")
    public function selectNextTrack() : Void;

    /**
     * Insert a new group track at the given index. Group tracks can only be 
     * inserted before the Master track.
     * @param index 
     * @return GroupTrack
     */
    @:native("insert_group_at")
    public function insertGroupAt(index :Int) : GroupTrack;

    /**
     * Add track at track_index to group at group_index by fit moving it to 
     * the right spot to the left of the group track, and then adding it. If 
     * group_index is not a group track, a new group track will be created and 
     * both tracks will be added to it.
     * 
     * @param trackIndex 
     * @param groupIndex 
     */
    @:native("add_track_to_group")
    public function addTrackToGroup(trackIndex :Int, groupIndex :Int) : Void;

    /**
     * Removes track from its immediate parent group and places it outside it to 
     * the left. Can only be called for tracks that are actually part of a group.
     * 
     * @param index 
     */
    @:native("remove_track_from_group")
    public function removeTrackFromGroup(index :Int) : Void;

    /**
     * Delete the group with the given index and all its member tracks. Index 
     * must be that of a group or a track that is a member of a group.
     * 
     * @param index 
     */
    @:native("delete_group_at")
    public function deleteGroupAt(index :Int) : Void;

    /**
     * Insert a new instrument at the given index. This will remap all existing 
     * notes in all patterns, if needed, and also update all other instrument 
     * links in the song. Can't have more than MAX_NUMBER_OF_INSTRUMENTS in a 
     * song.
     * 
     * @param index 
     * @return Instrument
     */
    @:native("insert_instrument_at")
    public function insertInstrumentAt(index :Int) : Instrument;

    /**
     * Delete an existing instrument at the given index. Renoise needs at least 
     * one instrument, thus trying to completely remove all instruments is not 
     * allowed. This will remap all existing notes in all patterns and update 
     * all other instrument links in the song.
     * 
     * @param index 
     */
    @:native("delete_instrument_at")
    public function deleteInstrumentAt(index :Int) : Void;

    /**
     * Swap the position of two instruments. Will remap all existing notes in 
     * all patterns and update all other instrument links in the song.
     * 
     * @param a 
     * @param b 
     */
    @:native("swap_instruments_at")
    public function swapInstrumentsAt(a :Int, b :Int) : Void;

    /**
     * Access to a single instrument by index. Use properties 'instruments' to 
     * iterate over all instruments and to query the instrument count.
     * 
     * @param index 
     * @return Instrument
     */
    public function instrument(index :Int) : Instrument;

    /**
     * Captures the current instrument (selects the instrument) from the current 
     * note column at the current cuor pos. Changes the selected instrument 
     * accordingly, but does not return the result. When no instrument is 
     * present at the current cuor pos, nothing will be done.
     */
    @:native("capture_instrument_from_pattern")
    public function captureInstrumentFromPattern() : Void;

    /**
     * Tries to captures the nearest instrument from the current pattern track, 
     * starting to look at the cuor pos, then advancing until an instrument is 
     * found. Changes the selected instrument accordingly, but does not return 
     * the result. When no instruments (notes) are present in the current 
     * pattern track, nothing will be done.
     */
    @:native("capture_nearest_instrument_from_pattern")
    public function captureNearestInstrumentFromPattern() : Void;

    /**
     * Access to a single pattern by index. Use properties 'patterns' to iterate 
     * over all patterns and to query the pattern count.
     * 
     * @param index 
     * @return Pattern
     */
    public function pattern(index :Int) : Pattern;

    /**
     * When rendering (see renoise.song().rendering, renoise.song().rendering_progress), 
     * the current render process is canceled. Otherwise, nothing is done.
     */
    @:native("cancel_rendering")
    public function cancelRendering() : Void;

    /**
     * Start rendering a section of the song or the whole song to a WAV file. 
     * Rendering job will be done in the background and the call will return 
     * back immediately, but the Renoise GUI will be blocked during rendering. 
     * The passed 'rendering_done_callback' function is called as soon as 
     * rendering is done, e.g. successfully completed. While rendering, the 
     * rendering status can be polled with the song().rendering and 
     * song().rendering_progress properties, for example, in idle notifier 
     * loops. If starting the rendering process fails (because of file IO erro 
     * for example), the render function will return false and the error message 
     * is set as the second return value. On success, only a single "true" value 
     * is returned. Parameter 'options' is a table with the following fields, 
     * all optional:
     * 
     * To render only specific tracks or columns, mute the undesired 
     * tracks/columns before starting to render. Parameter 'file_name' must 
     * point to a valid, maybe already existing file. If it already exists, the 
     * file will be silently overwritten. The renderer will automatically add a 
     * ".wav" extension to the file_name, if missing. Parameter 
     * 'rendering_done_callback' is ONLY called when rendering has succeeded. 
     * You can do something with the file you've passed to the renderer here, 
     * like for example loading the file into a sample buffer.
     *
     * @param options 
     * @param cb 
     * @return Bool
     */
    public function render(options :RenderingOptions, cb : Void -> Void) : Bool;

    /**
     * Load/save all global MIDI mappings in the song into a XRNM file. Returns 
     * true when loading/saving succeeded, else false and the error_message.
     * 
     * @param filename 
     * @return Bool
     */
    @:native("load_midi_mappings")
    public function loadMidiMappings(filename :String) : Bool;

    /**
     * Load/save all global MIDI mappings in the song into a XRNM file. Returns 
     * true when loading/saving succeeded, else false and the error_message.
     * 
     * @param filename 
     * @return Bool
     */
    @:native("save_midi_mappings")
    public function saveMidiMappings(filename :String) : Bool;

    /**
     * clear all MIDI mappings in the song
     */
    @:native("clear_midi_mappings")
    public function clearMidiMappings() : Void;
}