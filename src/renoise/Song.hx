package renoise;

@:native("renoise")
extern class Renoise
{
    extern public static function song() :Song;
}

extern class Song
{
    @:native("can_undo")
    public function canUndo() :Bool;
    public var tracks :Array<Dynamic>;
    public var transport :Transport;
}

extern class Transport
{
    public var playing :Bool;
    @:native("playing_observable")
    public var playingObservable :Observable;
}

extern class Observable
{
    @:native("add_notifier")
    function addNotifier(cb :Void -> Void) : Void;
    @:native("remove_notifier")
    function removeNotifier(cb :Void -> Void) : Void;
}