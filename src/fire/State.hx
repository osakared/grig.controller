package fire;

import fire.button.*;
import renoise.Midi.MidiOutputDevice;

class State
{
    public var knobType = new KnobType(KNOB_TYPE);
    public var volume = new Volume(VOLUME);
    public var pan = new Pan(PAN);
    public var filter = new Filter(FILTER);
    public var resonance = new Resonance(RESONANCE);
    public var patternUp = new PatternUp(PATTERN_UP);
    public var patternDown = new PatternDown(PATTERN_DOWN);
    public var browser = new Browser(BROWSER);
    public var select = new Select(SELECT);
    public var gridLeft = new GridLeft(GRID_LEFT);
    public var gridRight = new GridRight(GRID_RIGHT);
    public var muteSolo1 = new MuteSolo(MUTE_SOLO_1);
    public var muteSolo2 = new MuteSolo(MUTE_SOLO_2);
    public var muteSolo3 = new MuteSolo(MUTE_SOLO_3);
    public var muteSolo4 = new MuteSolo(MUTE_SOLO_4);
    public var step = new Step(STEP);
    public var note = new Note(NOTE);
    public var drum = new Drum(DRUM);
    public var perform = new Perform(PERFORM);
    public var shift = new Shift(SHIFT);
    public var alt = new Alt(ALT);
    public var patternSong = new PatternSong(PATTERN_SONG);
    public var play = new Play(PLAY);
    public var stop = new Stop(STOP);
    public var record = new Record(RECORD);
    public var grid = new Grid();
    public var display = new Display();

    public function new() : Void
    {

    }

    public function initialize(output :MidiOutputDevice) : Void
    {
        this.knobType.initialize(output);
        this.volume.initialize(output);
        this.pan.initialize(output);
        this.filter.initialize(output);
        this.resonance.initialize(output);
        this.patternUp.initialize(output);
        this.patternDown.initialize(output);
        this.browser.initialize(output);
        this.select.initialize(output);
        this.gridLeft.initialize(output);
        this.gridRight.initialize(output);
        this.muteSolo1.initialize(output);
        this.muteSolo2.initialize(output);
        this.muteSolo3.initialize(output);
        this.muteSolo4.initialize(output);
        this.step.initialize(output);
        this.note.initialize(output);
        this.drum.initialize(output);
        this.perform.initialize(output);
        this.shift.initialize(output);
        this.alt.initialize(output);
        this.patternSong.initialize(output);
        this.play.initialize(output);
        this.stop.initialize(output);
        this.record.initialize(output);
        this.grid.initialize(output);
        this.display.initialize(output);
    }
}