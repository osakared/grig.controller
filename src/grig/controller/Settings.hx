package grig.controller;

interface Settings
{
    /**
     * Creates a bool setting
     * @param name 
     * @param category 
     * @param defaultValue 
     * @return BoolSetting
     */
    public function createBoolSetting(name:String, category:String, defaultValue:Bool):BoolSetting;

    /**
     * Creates a string setting
     * @param name 
     * @param category 
     * @param defaultValue 
     * @return StringSetting
     */
    public function createStringSetting(name:String, category:String, defaultValue:String):StringSetting;

    /**
     * Creates an enum setting
     * @param name 
     * @param category 
     * @param type enum used
     * @param defaultValue 
     * @return EnumSetting<T>
     */
    public function createEnumSetting<T>(name:String, category:String, type:Enum<T>, defaultValue:T):EnumSetting<T>;
}