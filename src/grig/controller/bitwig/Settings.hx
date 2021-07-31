package grig.controller.bitwig;

import java.Lib;
import com.bitwig.extension.controller.api.Preferences;
import grig.controller.Setting;

using haxe.EnumTools;

typedef PreferenceKey = {
    name:String,
    category:String
}

class Settings implements grig.controller.Settings
{
    private inline static var MAX_CHARS = 32; // since Bitwig doesn't seem to have a default if you don't specify

    private var preferences:Preferences;

    public function new(preferences:Preferences)
    {
        this.preferences = preferences;
    }

    public function createBoolSetting(name:String, category:String, defaultValue:Bool):Setting<Bool>
    {
        var bitwigBoolSetting = preferences.getBooleanSetting(name, category, defaultValue);
        var boolSetting:Setting<Bool> = new BoolSetting(bitwigBoolSetting);
        return boolSetting;
    }

    public function createStringSetting(name:String, category:String, defaultValue:String):Setting<String>
    {
        var bitwigStringSetting = preferences.getStringSetting(name, category, MAX_CHARS, defaultValue);
        var stringSetting:Setting<String> = new StringSetting(bitwigStringSetting);
        return stringSetting;
    }

    public function createEnumSetting<T>(name:String, category:String, type:Enum<T>, defaultValue:T):Setting<T>
    {
        var optionStrings = [for (e in type.createAll()) Std.string(e)];
        var bitwigEnumSetting = preferences.getEnumSetting(name, category, Lib.nativeArray(optionStrings, true), Std.string(defaultValue));
        var enumSetting:Setting<T> = new EnumSetting<T>(bitwigEnumSetting, type);
        return enumSetting;
    }

    public function createIntSetting(name:String, category:String, minValue:Int, maxValue:Int, stepSize:Int,
        unit:String, defaultValue:Int):Setting<Int>
    {
        var bitwigFloatSetting = preferences.getNumberSetting(name, category, minValue, maxValue, stepSize, unit, defaultValue);
        var intSetting:Setting<Int> = new IntSetting(bitwigFloatSetting);
        return intSetting;
    }

    public function createFloatSetting(name:String, category:String, minValue:Float, maxValue:Float, stepSize:Float,
        unit:String, defaultValue:Float):Setting<Float>
    {
        var bitwigFloatSetting = preferences.getNumberSetting(name, category, minValue, maxValue, stepSize, unit, defaultValue);
        var floatSetting:Setting<Float> = new FloatSetting(bitwigFloatSetting);
        return floatSetting;
    }

    public function createColorSetting(name:String, category:String, defaultValue:Color):Setting<Color>
    {
        var bitwigColorSetting = preferences.getColorSetting(name, category, ColorHelper.toBitwigColor(defaultValue));
        var colorSetting:Setting<Color> = new ColorSetting(bitwigColorSetting);
        return colorSetting;
    }
}