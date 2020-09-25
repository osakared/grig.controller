package fire.output;

import renoise.RenoiseUtil;
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

    private function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private function drawLine(index :Int, row :Int, underline :Bool = false) : Void
    {
        index = RenoiseUtil.mod(index, 64);
        var line = lineString(index - 1);
        var noteColumn = Renoise.song().patterns[1].track(1).line(index).noteColumn(1);
        var note = noteColumn.noteString;
        var instrument = noteColumn.instrumentString;
        var volume = noteColumn.volumeString;
        var panning = noteColumn.panningString;

        var effectColumn = Renoise.song().patterns[1].track(1).line(index).effectColumn(1);
        var effectNumber = effectColumn.numberString;
        var effectAmount = effectColumn.amountString;

        _display.drawText('${line} ${note}|${instrument}|${volume}|${panning}|${effectNumber}|${effectAmount}', 0, 8 * row, underline);
        _display.renderRow(_outputDevice, row);
    }

    private function init() : Void
    {
        var playbackObserver = new PlaybackPositionObserver();

        _display.drawText(Renoise.song().track(1).name, 18, 0, true);
        _display.renderRow(_outputDevice, 0);

        var transport = Renoise.song().transport;
        playbackObserver.register(0, () -> {
            var padIndex = transport.playbackPos.line;
            _pads.clear();
            _pads.drawPad(127, 0, 0, padIndex - 1);
            _pads.render(_outputDevice);
            _display.clear();

            drawLine(padIndex - 3, 1);
            drawLine(padIndex - 2, 2);
            drawLine(padIndex - 1, 3);
            drawLine(padIndex, 4, true);
            drawLine(padIndex + 1, 5);
            drawLine(padIndex + 2, 6);
            drawLine(padIndex + 3, 7);
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