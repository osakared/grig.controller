package grig.controller;

interface HostMidiOut extends grig.midi.MidiSender
{
    /**
     * Sets velocity curve 
     * @param curve must have 128 values, each in the 0-128 range
     */
    public function setVelocityCurve(curve:Array<Int>):Void;
}