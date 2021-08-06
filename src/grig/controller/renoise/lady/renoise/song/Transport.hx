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

import lady.renoise.song.TransportPlayMode;
import lady.LArray;

extern class Transport
{
    //Constants
    public static var RECORD_PARAMETER_MODE_PATTERN : Int;
    public static var RECORD_PARAMETER_MODE_AUTOMATION : Int;

    /**
     * Playing.
     */
    public var playing : Bool;

    @:native("playing_observable")
    public var playingObservable : Observable;

    /**
     * Old school speed or new LPB timing used? With TIMING_MODEL_SPEED, tpl is 
     * used as speed factor. The lpb property is unused then. With 
     * TIMING_MODEL_LPB, tpl is used as event rate for effects only and lpb 
     * defines relationship between pattern lines and beats.
     */
    @:native("timing_model")
    public var timingModel (default, null) : TimingModel;

    /**
     * BPM, LPB, and TPL.
     */
    public var bpm : Int;

    @:native("bpm_observable")
    public var bpmObservable : Observable;

    /**
     * BPM, LPB, and TPL.
     */
    public var lpb : Int;

    @:native("lpb_observable")
    public var lpbObservable : Observable;

    /**
     * BPM, LPB, and TPL.
     */
    public var tpl : Int;

    @:native("tpl_observable")
    public var tplObservable : Observable;

    /**
     * Playback position.
     */
    @:native("playback_pos")
    public var playbackPos : SongPos;

    @:native("playback_pos_beats")
    public var playbackPosBeats : Int;

    /**
     * Edit position.
     */
    @:native("edit_pos")
    public var editPos : SongPos;

    @:native("edit_pos_beats")
    public var editPosBeats :Int;

    /**
     * Song length.
     */
    @:native("song_length")
    public var songLength (default, null) : SongPos;

    @:native("song_length_beats")
    public var songLengthBeats (default, null) : Int;

    /**
     * Loop.
     */
    @:native("loop_start")
    public var loopStart (default, null) : SongPos;

    @:native("loop_end")
    public var loopEnd (default, null) : SongPos;

    @:native("loop_range")
    public var loopRange (default, null) : LArray<SongPos>;

    @:native("loop_start_beats")
    public var loopStartBeats (default, null) : Int;

    @:native("loop_end_beats")
    public var loopEndBeats (default, null) : Int;

    @:native("loop_range_beats")
    public var loopRangeBeats (default, null) : LArray<Int>;

    @:native("loop_sequence_start")
    public var loopSequenceStart (default, null) : Int;

    @:native("loop_sequence_end")
    public var loopSequenceEnd (default, null) : Int;

    @:native("loop_sequence_range")
    public var loopSequenceRange (default, null) : LArray<Int>;

    @:native("loop_pattern")
    public var loopPattern : Bool;

    @:native("loop_pattern_observable")
    public var loopPatternObservable : Observable;

    @:native("loop_block_enabled")
    public var loopBlockEnabled : Bool;

    @:native("loop_block_start_pos")
    public var loopBlockStartPos (default, null) : SongPos;

    @:native("loop_block_range_coeff")
    public var loopBlockRangeCoeff : Int;

    /**
     * Edit modes.
     */
     @:native("edit_mode")
     public var editMode : Bool;
 
     @:native("edit_mode_observable")
     public var editModeObservable : Observable;
 
     @:native("edit_step")
     public var editStep : Int;
 
     @:native("edit_step_observable")
     public var editStepObservable : Observable;
 
     @:native("octave")
     public var octave : Int;
 
     @:native("octave_observable")
     public var octaveObservable : Observable;

    /**
     * Panic.
     */
     public function panic() : Void;

    /**
     * Mode: enum = PLAYMODE
     * 
     * @param mode 
     */
    public function start(mode :TransportPlayMode) : Void;

    /**
     * start playing the currently edited pattern at the given line offset
     * 
     * @param line 
     */
    @:native("start_at")
    public function startAt(line :Int) : Void;

    /**
     * stop playing. when already stopped this just stops all playing notes.
     */
    public function stop() : Void;

    /**
     * Immediately start playing at the given sequence position.
     * 
     * @param pos 
     */
    @:native("trigger_sequence")
    public function triggerSequence(pos :Int) : Void;

    /**
     * Append the sequence to the scheduled sequence list. Scheduled playback 
     * positions will apply as soon as the currently playing pattern play to end.
     * 
     * @param pos 
     */
    @:native("add_scheduled_sequence")
    public function addScheduledSequence(pos :Int) : Void;

    /**
     * Replace the scheduled sequence list with the given sequence.
     * 
     * @param pos 
     */
    @:native("set_scheduled_sequence")
    public function setScheduledSequence(pos :Int) : Void;

    /**
     * Move the block loop one segment forwards, when possible.
     */
    @:native("loop_block_move_forwards")
    public function loopBlockMoveForwards() : Void;

    /**
     * Move the block loop one segment backwards, when possible.
     */
    @:native("loop_block_move_backwards")
    public function loopBlockMoveBackwards() : Void;

    /**
     * Start a new sample recording when the sample dialog is visible, otherwise 
     * stop and finish it.
     */
    @:native("start_stop_sample_recording")
    public function startStopSampleRecording() : Void;

    /**
     * Cancel a currently running sample recording when the sample dialog is 
     * visible, otherwise do nothing.
     */
    @:native("cancel_sample_recording")
    public function cancelSampleRecording() : Void;
}