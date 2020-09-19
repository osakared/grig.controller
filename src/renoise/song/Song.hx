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

extern class Song
{
    @:native("can_undo")
    public function canUndo() :Bool;
    public var tracks :Array<Dynamic>;
    public var transport :Transport;

    @:native("selected_pattern_track")
    public var selectedPatternTrack : Dynamic;
    @:native("selected_pattern_track_observable")
    public var selectedPatternTrackObservable : Observable;

    @:native("selected_pattern_index")
    public var selectedPatternIndex : Int;
    @:native("selected_pattern_index_observable")
    public var selectedPatternIndexObservable : Observable;

    @:native("selected_sequence_index")
    public var selectedSequenceIndex : Int;
    @:native("selected_sequence_index_observable")
    public var selectedSequenceIndexObservable : Observable;

    @:native("selected_track_index")
    public var selectedTrackIndex : Int;
    @:native("selected_track_index_observable")
    public var selectedTrackIndexObservable : Observable;
}