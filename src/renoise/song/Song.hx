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