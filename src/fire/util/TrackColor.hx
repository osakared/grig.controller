package fire.util;

import renoise.Renoise;

class TrackColor
{
    public static var active (get, null) : Color;
    public static var activeExcited (get, null) : Color;
    public static var activeFlipped (get, null) : Color;
    public static var activeFlippedExcited (get, null) : Color;

    private static function init() : Void
    {
        Renoise.song().selectedTrackObservable.addNotifier(setColors);
        setColors();
    }

    private static function setColors() : Void
    {
        var trackColor = Renoise.song().selectedTrack.color;
        _active = Color.fromTrackColor(trackColor);
        _activeExcited = new Color(_active.r + EXCITED_VAL, _active.g + EXCITED_VAL, _active.b);
        _activeFlipped = new Color(_active.b, _active.g, _active.r);
        _activeFlippedExcited = new Color(_active.b + EXCITED_VAL, _active.g + EXCITED_VAL, _active.r);
    }

    private static function get_active() : Color
    {
        if(_active == null) {
            init();
        }
        return _active;
    }

    private static function get_activeExcited() : Color
    {
        if(_activeExcited == null) {
            init();
        }
        return _activeExcited;
    }

    private static function get_activeFlipped() : Color
    {
        if(_activeFlipped == null) {
            init();
        }
        return _activeFlipped;
    }

    private static function get_activeFlippedExcited() : Color
    {
        if(_activeFlippedExcited == null) {
            init();
        }
        return _activeFlippedExcited;
    }

    private static var _active : Color = null;
    private static var _activeExcited : Color = null;
    private static var _activeFlipped : Color = null;
    private static var _activeFlippedExcited : Color = null;
    private static var EXCITED_VAL = 40;
}