package renoise;

extern class Observable
{
    @:native("add_notifier")
    function addNotifier(cb :Void -> Void) : Void;
    @:native("remove_notifier")
    function removeNotifier(cb :Void -> Void) : Void;
}