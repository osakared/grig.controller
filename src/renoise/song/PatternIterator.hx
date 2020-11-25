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

import lua.NativeIterator;

extern class PatternIterator
{
    /**
     * Iterate over all pattern lines in the song.
     * @param visiblePatternsOnly 
     * @return NativeIterator<
     */
    @:native("lines_in_song")
    public function linesInSong(visiblePatternsOnly :Bool) : NativeIterator<{pos:Int, line:PatternLine}>;

    /**
     * Iterate over all note/effect_ columns in the song.
     * @param visibleOnly 
     * @return NativeIterator<
     */
    @:native("note_columns_in_song")
    public function noteColumnsInSong(visibleOnly :Bool) : NativeIterator<{pos:Int, column:NoteColumn}>;

    @:native("effect_columns_in_song")
    public function effectColumnsInSong(visibleOnly :Bool) : NativeIterator<{pos:Int, column:EffectColumn}>;

    /**
     * Iterate over all lines in the given pattern only.
     * @param patternIndex 
     * @return NativeIterator<
     */
    @:native("lines_in_pattern")
    public function linesInPattern(patternIndex :Int) : NativeIterator<{pos:Int, line:PatternLine}>;

    /**
     * Iterate over all note/effect columns in the specified pattern.
     * @param visibleOnly 
     * @return NativeIterator<
     */
    @:native("note_columns_in_pattern")
    public function noteColumnsInPattern(visibleOnly :Bool) : NativeIterator<{pos:Int, column:NoteColumn}>;

    @:native("effect_columns_in_pattern")
    public function effectColumnsInPattern(visibleOnly :Bool) : NativeIterator<{pos:Int, column:EffectColumn}>;

    /**
     * Iterate over all lines in the given track only.
     * @param visiblePatternsOnly 
     * @return NativeIterator<
     */
    @:native("lines_in_track")
    public function linesInTrack(visiblePatternsOnly :Bool) : NativeIterator<{pos:Int, column:PatternLine}>;

    /**
     * Iterate over all note/effect columns in the specified track.
     * @param visibleOnly 
     * @return NativeIterator<
     */
    @:native("note_columns_in_track")
    public function noteColumnsInTrack(visibleOnly :Bool) : NativeIterator<{pos:Int, line:NoteColumn}>;

    @:native("effect_columns_in_track")
    public function effectColumnsInTrack(visibleOnly :Bool) : NativeIterator<{pos:Int, column:EffectColumn}>;

    /**
     * Iterate over all lines in the given pattern, track only.
     * @param patternIndex 
     * @param trackIndex 
     * @return NativeIterator<
     */
    @:native("lines_in_pattern_track")
    public function linesInPatternTrack(patternIndex :Int, trackIndex :Int) : NativeIterator<{pos:Int, line:PatternLine}>;

    /**
     * Iterate over all note/effect columns in the specified pattern track.
     * @param patternIndex 
     * @param trackIndex 
     * @param visibleOnly 
     * @return NativeIterator<
     */
    @:native("note_columns_in_pattern_track")
    public function noteColumnsInPatternTrack(patternIndex :Int, trackIndex :Int, visibleOnly :Bool) : NativeIterator<{pos:Int, column:NoteColumn}>;

    @:native("effect_columns_in_pattern_track")
    public function effectColumnsInPatternTrack(patternIndex :Int, trackIndex :Int, visibleOnly :Bool) : NativeIterator<{pos:Int, column:EffectColumn}>;
}