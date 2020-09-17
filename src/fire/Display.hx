package fire;

import renoise.Midi.MidiOutputDevice;
import fire.Text;

class Display
{
    private static var DISPLAY_WIDTH = 128;
    private static var DISPLAY_HEIGHT = 64;

    private var _y :Int = 0;

    public function new() : Void
    {
        _bitmap = [];
        this.clear();
    }

    public function initialize(output :MidiOutputDevice) : Void
    {
        
    }

    public function clear() : Void
    {
        for(i in 0...(DISPLAY_WIDTH*DISPLAY_HEIGHT)) {
            _bitmap[i] = 0;
        }
    }

    public function drawTest(output :MidiOutputDevice, isUp :Bool) : Void
    {
        clear();
        if(isUp) {
            _y--;
            if(_y < 0) {
                _y = 0;
            }
        }
        else {
            _y++;
            if(_y > 7) {
                _y = 7;
            }
        }
        // drawString(_bitmap, Text.make("abcdefgh"), 0, 0);
        // drawString(_bitmap, Text.make("ijklmnopq"), 0, 8);
        // drawString(_bitmap, Text.make("rstuvwxy"), 0, 16);
        // drawString(_bitmap, Text.make("z"), 0, 24);
        drawString(_bitmap, Text.make("Renoise Fire"), 56, 8 * _y);
        var binaryData = convertBitmap(_bitmap);
        var data = bitsToInt(binaryData);
        drawBitmap(output, data);
    }

    private static function drawString(bitmap :Array<Int>, letter :Array<Array<Int>>, x :Int, y :Int) : Void
    {
        var yIndex = 0;
        for(line in letter) {
            var xIndex = 0;
            for(value in line) {
                var pos = (yIndex + y) * DISPLAY_WIDTH + xIndex + x;
                bitmap[pos] = value;
                xIndex++;
            }
            yIndex++;
        }
    }

    private static function drawBitmap(output :MidiOutputDevice, data :Array<Int>) : Void
    {
        var hh = (data.length + 4) >> 7;
        var ll = (data.length + 4) & 0x7F;
        var msg = [0xF0,0x47,0x7F,0x43,0x0E, hh, ll, 0x00, 0x07, 0x00, 0x7F];
        for(pixel in data) {
            msg.push(pixel);
        }
        msg.push(0xF7);
        output.send(lua.Table.fromArray(msg));
    }

    private static function bitsToInt(byteArray :Array<Int>) : Array<Int>
    {
        var bytes = [];
        for(i in 0...byteArray.length) {
            var arrayIndex = Math.floor(i / 7);
            if(bytes[arrayIndex] == null) {
                bytes[arrayIndex] = 0;
            }
            bytes[arrayIndex] = (bytes[arrayIndex] << 1) | byteArray[i];
        }

        return bytes;
    };

    private static function convertBitmap(bitmap :Array<Int>) : Array<Int>
    {
        var L = 8;
        var screenWidth = DISPLAY_WIDTH;
        var data = [];

        for(y in 0...DISPLAY_HEIGHT) {
            for(x in 0...DISPLAY_WIDTH) {
                var nX = x * L;
                var nY = Math.floor(y / L) * L * screenWidth + (y % L);
                var rY = 7 - (y % 8) + (8 * Std.int(y/8));
                var displayIndex :Int = nX + nY;
                var pos = rY*DISPLAY_WIDTH + x;
                data[displayIndex] = bitmap[pos];
            }  
        }

        return data;
    }

    private var _bitmap :Array<Int>;
}
