package grig.controller;

interface EnumSetting<T>
{
    public function get():T;
    public function set(value:T):Void;
}