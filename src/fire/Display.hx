package fire;

import lua.Lua;
import renoise.Midi.MidiOutputDevice;
import fire.Text;
import fire.LuaArray;

class Display
{
    private static var DISPLAY_WIDTH = 128;
    private static var DISPLAY_HEIGHT = 64;

    public function new() : Void
    {
        _bitmap = new LuaArray([]);
        _data = new LuaArray([]);
        _msg = new LuaArray([]);
        _bytes = new LuaArray([]);
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
        drawString(_bitmap, Text.make("abcdefgh"), 0, 0);
        drawString(_bitmap, Text.make("ijklmnopq"), 0, 8);
        drawString(_bitmap, Text.make("rstuvwxy"), 0, 16);
        drawString(_bitmap, Text.make("z"), 0, 24);
        drawString(_bitmap, Text.make("Renoise Fire"), 56, 8 * 4);
        var binaryData = convertBitmap(_bitmap);
        var data = bitsToInt(binaryData);
        drawBitmap(output, data);
        Lua.collectgarbage(Stop);
    }

    private static function drawString(bitmap :LuaArray<Int>, letter :Array<Array<Int>>, x :Int, y :Int) : Void
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

    private function drawBitmap(output :MidiOutputDevice, data :LuaArray<Int>) : Void
    {
        _msg.clear();
        var hh = (data.length + 4) >> 7;
        var ll = (data.length + 4) & 0x7F;
        _msg.push(0xF0);
        _msg.push(0x47);
        _msg.push(0x7F);
        _msg.push(0x43);
        _msg.push(0x0E);
        _msg.push(hh);
        _msg.push(ll);
        _msg.push(0x00);
        _msg.push(0x07);
        _msg.push(0x00);
        _msg.push(0x7F);
        for(pixel in data) {
            _msg.push(pixel);
        }
        _msg.push(0xF7);
        output.send(_msg);
    }

    private function bitsToInt(byteArray :LuaArray<Int>) : LuaArray<Int>
    {
        _bytes.clear();
        for(i in 0...byteArray.length) {
            var arrayIndex = Math.floor(i / 7);
            if(_bytes[arrayIndex] == null) {
                _bytes[arrayIndex] = 0;
            }
            _bytes[arrayIndex] = (_bytes[arrayIndex] << 1) | byteArray[i];
        }

        return _bytes;
    };

    private function convertBitmap(bitmap :LuaArray<Int>) : LuaArray<Int>
    {
        var L = 8;
        var screenWidth = DISPLAY_WIDTH;

        for(y in 0...DISPLAY_HEIGHT) {
            for(x in 0...DISPLAY_WIDTH) {
                var nX = x * L;
                var nY = Math.floor(y / L) * L * screenWidth + (y % L);
                var rY = 7 - (y % 8) + (8 * Std.int(y/8));
                var displayIndex :Int = nX + nY;
                var pos = rY*DISPLAY_WIDTH + x;
                _data[displayIndex] = bitmap[pos];
            }  
        }

        return _data;
    }

    private var _bitmap :LuaArray<Int>; 
    private var _data :LuaArray<Int>; 
    private var _bytes :LuaArray<Int>; 
    private var _msg :LuaArray<Int>; 
}
