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
        _grid = new OutputGrid();
        _buttons = new ButtonLights();
        this.init();
    }

    private function init() : Void
    {
        var playbackObserver = new PlaybackPositionObserver();
        var transport = Renoise.song().transport;
        playbackObserver.register(0, () -> {
            var padIndex = transport.playbackPos.line - 1;
            _grid.clear();
            _grid.drawPad(127, 0, 0, padIndex);
            _grid.drawPad(127, 127, 0, padIndex + 1);
            _grid.drawPad(127, 0, 127, padIndex + 2);
            _grid.render(_outputDevice);

            var isSage = padIndex % 2 == 0;
            _display.clear();
            _display.drawText(isSage ? "sage" : "neptune", 0, 0);
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
    }

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _grid :OutputGrid;
    private var _buttons :ButtonLights;
}