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

package fire.fromRenoise;

import fire.util.Math;
import lady.renoise.song.SongPos;
import lady.renoise.Renoise;
import fire.util.Signal1;

class RenoiseState
{
    public var scaleMode (default, null) : ScaleMode;
    public var trackColumn (default, null) : Signal1<TrackColumn>;
    public var trackIndex (get, set) : Int;
    public var instrumentIndex (get, set) : Int;
    public var currentPos (get, null) : SongPos;
    public var isPlaying (get, null) : Bool;
    public var isRecording (get, null) : Bool;
    public var editStep (get, set) : Int;
    public var bpm (get, set) : Int;

    public function new() : Void
    {
        this.scaleMode = new ScaleMode();
        setTrack();
    }

    private function setTrack() : Void
    {
        var track = Renoise.song().selectedNoteColumnIndex != 0
            ? TrackNote(Renoise.song().selectedNoteColumnIndex)
            : TrackEffect(Renoise.song().selectedEffectColumnIndex);
        this.trackColumn = new Signal1(track);
    }

    private inline function get_trackIndex() : Int
    {
        return Renoise.song().selectedTrackIndex;
    }

    private inline function set_trackIndex(index :Int) : Int
    {
        var trackIndex = Math.clamp(index, 1, Renoise.song().tracks.length);
        Renoise.song().selectedTrackIndex = trackIndex;
        return trackIndex;
    }

    private inline function get_instrumentIndex() : Int
    {
        return Renoise.song().selectedInstrumentIndex;
    }

    private function set_instrumentIndex(index :Int) : Int
    {
        var instIndex = Math.clamp(index, 1, Renoise.song().instruments.length);
        Renoise.song().selectedInstrumentIndex = instIndex;
        return instIndex;
    }

    private function get_currentPos() : SongPos
    {
        var transport = Renoise.song().transport;
        return  transport.editMode
            ? transport.editPos
            : transport.playbackPos;
    }

    private inline function get_isPlaying() : Bool
    {
        return Renoise.song().transport.playing;
    }

    private inline function get_isRecording() : Bool
    {
        return Renoise.song().transport.editMode;
    }

    private inline function get_editStep() : Int
    {
        return Renoise.song().transport.editStep;
    }

    private function set_editStep(step :Int) : Int
    {
        var step = Math.clamp(step, 0, 64);
        Renoise.song().transport.editStep = step;
        return step;
    }

    private inline function get_bpm() : Int
    {
        return Renoise.song().transport.bpm;
    }

    private function set_bpm(bpm :Int) : Int
    {
        var bpm = Math.clamp(bpm, 32, 999);
        Renoise.song().transport.bpm = bpm;
        return bpm;
    }
}

enum TrackColumn
{
    TrackNote(noteColumnIndex :Int);
    TrackEffect(trackColumnIndex :Int);
}