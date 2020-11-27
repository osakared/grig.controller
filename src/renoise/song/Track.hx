/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package renoise.song;

extern class Track
{
    /**
     * Type, name, color.
     */
    public var type (default, null) : TrackType;

    public var name :String;

    @:native("name_observable")
    public var nameObservable :Observable;

    public var color :lua.Table<Int, Int>;

    @:native("color_observable")
    public var colorObservable :Observable;

    @:native("color_blend")
    public var colorBlend :Int;

    @:native("color_blend_observable")
    public var colorBlendObservable :Observable;

    /**
     * Mute and solo states. Not available for the master track.
     */
    @:native("mute_state")
    public var muteState : MuteState;

    @:native("mute_state_observable")
    public var muteStateObservable : Observable;

    @:native("solo_state")
    public var soloState : Bool;

    @:native("solo_state_observable")
    public var soloStateObservable : Observable;

    /**
     * Volume, panning, width.
     */
    @:native("prefx_volume")
    public var prefxVolume : DeviceParameter;

    @:native("prefx_panning")
    public var prefxPanning : DeviceParameter;

    @:native("prefx_width")
    public var prefxWidth : DeviceParameter;

    @:native("postfx_volume")
    public var postfxVolume : DeviceParameter;

    @:native("postfx_panning")
    public var postfxPanning : DeviceParameter;

    /**
     * Collapsed/expanded visual appearance.
     */
    public var collapsed : Bool;

    @:native("collapsed_observable")
    public var collapsedObservable : Observable;

    /**
     * Returns most immediate group parent or nil if not in a group.
     */
    @:native("group_parent")
    public var groupParent (default, null) : GroupTrack;

    /**
     * Output routing.
     */
    @:native("available_output_routings")
    public var availableOutputRoutings (default, null) : lua.Table<Int, String>;

    @:native("output_routing")
    public var outputRouting : String;

    @:native("output_routing_observable")
    public var outputRoutingObservable : Observable;

    /**
     * Delay.
     */
    @:native("output_delay")
    public var outputDelay : Int;

    @:native("output_delay_observable")
    public var outputDelayObservable : Observable;

    /**
     * Pattern editor columns.
     */
    @:native("max_effect_columns")
    public var maxEffectColumns (default, null) : Int;

    @:native("min_effect_columns")
    public var minEffectColumns (default, null) : Int;

    @:native("max_note_columns")
    public var maxNoteColumns (default, null) : Int;

    @:native("min_note_columns")
    public var minNoteColumns (default, null) : Int;

    @:native("visible_effect_columns")
    public var visibleEffectColumns : Int;

    @:native("visible_effect_columns_observable")
    public var visibleEffectColumnsObservable : Observable;

    @:native("visible_note_columns")
    public var visibleNoteColumns : Int;

    @:native("visible_note_columns_observable")
    public var visibleNoteColumnsObservable : Observable;

    @:native("volume_column_visible")
    public var volumeColumnVisible : Bool;

    @:native("volume_column_visible_observable")
    public var volumeColumnVisibleObservable : Observable;

    @:native("panning_column_visible")
    public var panningColumVisible : Bool;

    @:native("panning_column_visible_observable")
    public var panningColumnVisibleObservable : Observable;

    @:native("delay_column_visible")
    public var delayColumnVisible : Bool;

    @:native("delay_column_visible_observable")
    public var delayColumnVisibleObservable : Observable;

    @:native("sample_effects_column_visible")
    public var sampleEffectsColumnVisible : Bool;

    @:native("sample_effects_column_visible_observable")
    public var sampleEffectsColumnVisibleObservable : Observable;

    /**
     * Devices.
     */
    @:native("available_devices")
    public var availableDevices (default, null) : lua.Table<Int, String>;

    /**
     * Returns a list of tables containing more information about the devices. 
     * Each table has the following fields: { path, -- The device's path used by 
     * insert_device_at() name, -- The device's name short_name, -- The device's 
     * name as displayed in shortened lists favorite_name, -- The device's name 
     * as displayed in favorites is_favorite, -- true if the device is a 
     * favorite is_bridged -- true if the device is a bridged plugin }
     */
    @:native("available_device_infos")
    public var availableDeviceInfos (default, null) : lua.Table<Int, String>;

    public var devices (default, null) : AudioDevice;

    @:native("devices_observable")
    public var devicesObservable (default, null) : Observable;


    /**
     * Insert a new device at the given position. "device_path" must be one of 
     * renoise.song().tracks[].available_devices.
     * 
     * @param path 
     * @param index 
     * @return AudioDevice
     */
    @:native("insert_device_at")
    public function insertDeviceAt(path :String, index :Int) : AudioDevice;

    /**
     * Delete an existing device in a track. The mixer device at index 1 can not 
     * be deleted from a track.
     * 
     * @param index 
     */
    @:native("delete_device_at")
    public function deleteDeviceAt(index :Int) : Void;

    /**
     * Swap the positions of two devices in the device chain. The mixer device 
     * at index 1 can not be swapped or moved.
     * 
     * @param a 
     * @param b 
     */
    @:native("swap_devices_at")
    public function swapDevicesAt(a :Int, b :Int) : Void;

    /**
     * Access to a single device by index. Use properties 'devices' to iterate 
     * over all devices and to query the device count.
     * 
     * @param index 
     * @return AudioDevice
     */
    public function device(index :Int) : AudioDevice;

    /**
     * Uses default mute state from the prefs. Not for the master track.
     */
    public function mute() : Void;

    public function unmute() : Void;

    public function solo() : Void;

    /**
     * Note column mutes. Only valid within (1-track.max_note_columns)
     * 
     * @param index 
     * @return Bool
     */
    @:native("column_is_muted")
    public function columnIsMuted(index :Int) : Bool;

    @:native("column_is_muted_observable")
    public function columnIsMutedObservable(index :Int) : Observable;

    @:native("set_column_is_muted")
    public function setColumnIsMuted(index :Int, muted :Bool) : Void;

    /**
     * Note column names. Only valid within (1-track.max_note_columns)
     * 
     * @param index 
     * @return String
     */
    @:native("column_name")
    public function columnName(index :Int) : String;

    @:native("column_name_observable")
    public function columnNameObservable(index :Int) : Observable;

    @:native("set_column_name")
    public function setColumnName(index :Int, name :String) : Void;

    /**
     * Swap the positions of two note or effect columns within a track.
     * 
     * @param a 
     * @param b 
     */
    @:native("swap_note_columns_at")
    public function swapNoteColumnsAt(a :Int, b :Int) : Void;
    
    @:native("swap_effect_columns_at")
    public function swapEffectColumnsAt(a :Int, b :Int) : Void;
}