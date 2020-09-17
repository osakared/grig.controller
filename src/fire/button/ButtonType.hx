package fire.button;

@:enum
abstract ButtonType(Int) from Int to Int
{
    var KNOB_TYPE = 26;
    var VOLUME = 16;
    var PAN = 17;
    var FILTER = 18;
    var RESONANCE = 19;
    var PATTERN_UP = 31;
    var PATTERN_DOWN = 32;
    var BROWSER = 33;
    var SELECT = 25;
    var GRID_LEFT = 34;
    var GRID_RIGHT = 35;
    var MUTE_SOLO_1 = 36;
    var MUTE_SOLO_2 = 37;
    var MUTE_SOLO_3 = 38;
    var MUTE_SOLO_4 = 39;
    var STEP = 44;
    var NOTE = 45;
    var DRUM = 46;
    var PERFORM = 47;
    var SHIFT = 48;
    var ALT = 49;
    var PATTERN_SONG = 50;
    var PLAY = 51;
    var STOP = 52;
    var RECORD = 53;
}