package fire.output.button;

import fire.button.ButtonType;

class ButtonLights
{
    public var knobType = new ButtonLight(ButtonType.KNOB_TYPE);
    public var patternUp = new ButtonLight(ButtonType.PATTERN_UP);
    public var patternDown = new ButtonLight(ButtonType.PATTERN_DOWN);
    public var browser = new ButtonLight(ButtonType.BROWSER);
    public var gridLeft = new ButtonLight(ButtonType.GRID_LEFT);
    public var gridRight = new ButtonLight(ButtonType.GRID_RIGHT);
    public var muteSolo1 = new ButtonLight(ButtonType.MUTE_SOLO_1);
    public var muteSolo2 = new ButtonLight(ButtonType.MUTE_SOLO_2);
    public var muteSolo3 = new ButtonLight(ButtonType.MUTE_SOLO_3);
    public var muteSolo4 = new ButtonLight(ButtonType.MUTE_SOLO_4);
    public var step = new ButtonLight(ButtonType.STEP);
    public var note = new ButtonLight(ButtonType.NOTE);
    public var drum = new ButtonLight(ButtonType.DRUM);
    public var perform = new ButtonLight(ButtonType.PERFORM);
    public var shift = new ButtonLight(ButtonType.SHIFT);
    public var alt = new ButtonLight(ButtonType.ALT);
    public var patternSong = new ButtonLight(ButtonType.PATTERN_SONG);
    public var play = new ButtonLight(ButtonType.PLAY);
    public var stop = new ButtonLight(ButtonType.STOP);
    public var record = new ButtonLight(ButtonType.RECORD);

    public function new() : Void
    {
    }
}