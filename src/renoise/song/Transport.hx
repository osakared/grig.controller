package renoise.song;

extern class Transport
{
    public var playing :Bool;
    @:native("playing_observable")
    public var playingObservable :Observable;

    @:native("follow_player")
    public var followPlayer : Bool;
    @:native("follow_player_observable")
    public var followPlayerObservable : Observable;

    @:native("playback_pos")
    public var playbackPos : SongPos;
}