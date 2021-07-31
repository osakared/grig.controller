package grig.controller.bitwig;

import java.Lib;
import com.bitwig.extension.controller.api.Preferences;

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

    public function createBoolSetting(name:String, category:String, defaultValue:Bool):grig.controller.Setting<Bool>
    {
        var bitwigBoolSetting = preferences.getBooleanSetting(name, category, defaultValue);
        var boolSetting:grig.controller.Setting<Bool> = new BoolSetting(bitwigBoolSetting);
        return boolSetting;
    }

    public function createStringSetting(name:String, category:String, defaultValue:String):grig.controller.Setting<String>
    {
        var bitwigStringSetting = preferences.getStringSetting(name, category, MAX_CHARS, defaultValue);
        var stringSetting:grig.controller.Setting<String> = new StringSetting(bitwigStringSetting);
        return stringSetting;
    }

    public function createEnumSetting<T>(name:String, category:String, type:Enum<T>, defaultValue:T):grig.controller.Setting<T>
    {
        var optionStrings = [for (e in type.createAll()) Std.string(e)];
        var bitwigEnumSetting = preferences.getEnumSetting(name, category, Lib.nativeArray(optionStrings, true), Std.string(defaultValue));
        var enumSetting:grig.controller.Setting<T> = new EnumSetting<T>(bitwigEnumSetting, type);
        return enumSetting;
    }
}