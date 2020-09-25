package fire.output;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.output.Display;
import fire.output.button.ButtonLights;
import fire.output.Grid as OutputGrid;
import renoise.PlaybackPositionObserver;

class Output
{
    public function new(outputDevice :MidiOutputDevice) : Void
    {
        _outputDevice = outputDevice;
        _display = new Display();
        _pads = new OutputGrid(_outputDevice);
        _buttons = new ButtonLights();
        _cachedNotes = [];
        this.init();
    }

    private function init() : Void
    {
        var playbackObserver = new PlaybackPositionObserver();
        var transport = Renoise.song().transport;
        playbackObserver.register(0, () -> {
            var padIndex = transport.playbackPos.line - 1;
            _pads.clear();
            _pads.drawPad(127, 0, 0, padIndex);
            _pads.render(_outputDevice);

            _display.clear();
            _display.drawText('${transport.playbackPos.line} | hi', 0, 0);
            _display.render(_outputDevice);
        });

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            if(Renoise.song().transport.playing) {
                _buttons.play.send(_outputDevice, 3);
            }
            else {
                _buttons.play.send(_outputDevice, 0);
            }
        });


        // renoise.song()
        Renoise.song().selectedPatternTrackObservable.addNotifier(() -> {
            // Renoise.app().showStatus("Selected Pattern Track Change!");
        });
    }

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _pads :OutputGrid;
    private var _buttons :ButtonLights;

    private var _cachedNotes :Array<Int>;
}