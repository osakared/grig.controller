package fire.output;

import fire.util.Modifiers;
import renoise.RenoiseUtil;
import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.output.Display;
import fire.output.button.ButtonLights;
import fire.output.Grid as OutputGrid;
import renoise.LineChaneObserver;

class Output
{
    public function new(outputDevice :MidiOutputDevice, modifiers :Modifiers) : Void
    {
        _outputDevice = outputDevice;
        _modifiers = modifiers;
        _display = new Display();
        _pads = new OutputGrid(_outputDevice);
        _buttons = new ButtonLights();
        _cachedNotes = [];
        this.initializeListeners();
    }

    private function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private function initializeListeners() : Void
    {
        var lineObserver = new LineChaneObserver();
        lineObserver.register(0, makeDrawCalls);
        Renoise.song().selectedPatternTrackObservable.addNotifier(makeDrawCalls);
        // Renoise.song().selectedPatternIndexObservable.addNotifier(makeDrawCalls); ?? maybe this one too?

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            if(Renoise.song().transport.playing) {
                _buttons.play.send(_outputDevice, 3);
            }
            else {
                _buttons.play.send(_outputDevice, 0);
            }
        });
    }

    private function makeDrawCalls() : Void
    {
        _display.drawText(Renoise.song().selectedTrack.name, 18, 0, false, false);
        _display.renderRow(_outputDevice, 0);

        if(Renoise.song().selectedNoteColumnIndex != 0 || Renoise.song().selectedEffectColumnIndex != 0) {
            var transport = Renoise.song().transport;
            var padIndex = transport.playbackPos.line;
            _pads.clear();
            _pads.drawPad(127, 0, 0, padIndex - 1);
            _pads.render(_outputDevice);
            _display.clear();

            var noteColumn = Renoise.song().selectedNoteColumnIndex == 0
                ? 1
                : Renoise.song().selectedNoteColumnIndex;
            var effectColumn = Renoise.song().selectedEffectColumnIndex == 0
                ? 1
                : Renoise.song().selectedEffectColumnIndex;

            drawLine(padIndex - 3, 1, noteColumn, effectColumn);
            drawLine(padIndex - 2, 2, noteColumn, effectColumn);
            drawLine(padIndex - 1, 3, noteColumn, effectColumn);
            drawLine(padIndex, 4, noteColumn, effectColumn, true);
            drawLine(padIndex + 1, 5, noteColumn, effectColumn);
            drawLine(padIndex + 2, 6, noteColumn, effectColumn);
            drawLine(padIndex + 3, 7, noteColumn, effectColumn);
        }
    }

    private function drawLine(index :Int, row :Int, noteColumn :Int, effectColumn :Int, highlight :Bool = false) : Void
    {
        index = RenoiseUtil.mod(index, 64);
        var line = lineString(index - 1);
        var isUnderlined = (index - 1) % Renoise.song().transport.lpb == 0;
        var x = _display.drawText(line, 0, 8 * row, false, isUnderlined);
        x = _display.drawText(" ", x, 8 * row, false, false);

        var noteColumn = Renoise.song().selectedPatternTrack.line(index).noteColumn(noteColumn);
        x = _display.drawText(noteColumn.noteString, x, 8 * row, false, _modifiers.gridIndex == 0 && highlight);
        x = _display.drawText("|", x, 8 * row, false, false);
        x = _display.drawText(noteColumn.instrumentString, x, 8 * row, false, _modifiers.gridIndex == 1 && highlight);
        x = _display.drawText("|", x, 8 * row, false, false);
        x = _display.drawText(noteColumn.volumeString, x, 8 * row, false, _modifiers.gridIndex == 2 && highlight);
        x = _display.drawText("|", x, 8 * row, false, false);
        var effectColumn = Renoise.song().selectedPatternTrack.line(index).effectColumn(effectColumn);
        x = _display.drawText(effectColumn.numberString, x, 8 * row, false, _modifiers.gridIndex == 3 && highlight);
        _display.drawText(effectColumn.amountString, x, 8 * row, false, _modifiers.gridIndex == 4 && highlight);
        _display.renderRow(_outputDevice, row);
    }

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _pads :OutputGrid;
    private var _buttons :ButtonLights;
    private var _modifiers :Modifiers;

    private var _cachedNotes :Array<Int>;
}