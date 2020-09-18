package renoise;

@:native("PlaybackPositionObserver")
extern class PlaybackPositionObserver
{
    @:selfCall
    public function new() : Void;
    public function register(id :Int, cb :Void -> Void) :Void;
    public function unregister(id :Int) :Void;
}