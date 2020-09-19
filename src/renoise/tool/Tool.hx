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

package renoise.tool;

import lua.Table;

extern class Tool
{
    @:native("bundle_path")
    public var bundlePath : String;

    @:native("app_became_active_observable")
    public var appBecameActiveObservable :Observable;

    @:native("app_resigned_active_observable")
    public var appResignedActiveObservable :Observable;

    @:native("app_idle_observable")
    public var appIdleObservable :Observable;

    @:native("app_release_document_observable")
    public var appReleaseDocumentObservable :Observable;

    @:native("app_new_document_observable")
    public var appNewDocumentObservable :Observable;

    @:native("app_saved_document_observable")
    public var appSavedDocumentObservable :Observable;
    
    //--

    @:native("has_menu_entry")
    public function hasMenuEntry(name :String) : Bool;

    @:native("add_menu_entry")
    public function addMenuEntry(entry :MenuEntry) : Void;

    @:native("remove_menu_entry")
    public function removeMenuEntry(name :String) : Void;

    //--

    @:native("has_keybinding")
    public function hasKeybinding(name :String) : Bool;

    @:native("add_keybinding")
    public function addKeybinding(def :Dynamic) : Void;

    @:native("remove_keybinding")
    public function removeKeybinding(name :String) : Void;

    //--

    @:native("has_midi_mapping")
    public function hasMidiMapping(name :String) : Bool;

    @:native("add_midi_mapping")
    public function addMidiMapping(def :Dynamic) : Void;

    @:native("remove_midi_mapping")
    public function removeMidiMapping(name :String) : Void;

    //--

    @:native("has_file_import_hook")
    public function hasFileImportHook(category :String, extTable :Dynamic) : Bool;

    @:native("add_file_import_hook")
    public function addFileImportHook(def :Dynamic) : Void;

    @:native("remove_file_import_hook")
    public function removeFileImportHook(category :String, extTable :Dynamic) : Void;

    //--

    @:native("has_timer")
    public function has_timer(cb : Void -> Void) : Bool;

    @:native("add_timer")
    public function add_timer(cb : Void -> Void, ms :Int) : Void;

    @:native("remove_timer")
    public function remove_timer(cb : Void -> Void) : Void;
}

abstract MenuEntry(lua.Table<String, Dynamic>) to lua.Table<String, Dynamic>
{
    public inline function new(name :String, invoke :Void -> Void) : Void
    {
        this = Table.create({name:name, invoke:invoke});
    }    
}