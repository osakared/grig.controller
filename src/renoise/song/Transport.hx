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

extern class Transport
{
    /**
     * Panic.
     */
    public function panic() : Void;

    /**
     * Mode: enum = PLAYMODE
     * 
     * @param mode 
     */
    public function start(mode :Dynamic) : Void;

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
    public var timingModel (default, null) : Dynamic;

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
}