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
    /**
     * Full absolute path and name to your tool's bundle directory.
     */
    @:native("bundle_path")
    public var bundlePath : String;

    /**
     * Invoked as soon as the application becomes the foreground window. For 
     * example, when you ATL-TAB to it, or activate it with the mouse from 
     * another app to Renoise.
     */
    @:native("app_became_active_observable")
    public var appBecameActiveObservable :Observable;

    /**
     * Invoked as soon as the application looses focus and another app becomes 
     * the foreground window.
     */
    @:native("app_resigned_active_observable")
    public var appResignedActiveObservable :Observable;

    /**
     * Invoked periodically in the background, more often when the work load is 
     * low, less often when Renoise's work load is high. The exact interval is 
     * undefined and can not be relied on, but will be around 10 times per sec. 
     * You can do stuff in the background without blocking the application here. 
     * Be gentle and don't do CPU heavy stuff please!
     */
    @:native("app_idle_observable")
    public var appIdleObservable :Observable;

    /**
     * Invoked each time before a new document gets created or loaded, aka the 
     * last time renoise.song() still points to the old song before a new one 
     * arrives. You can explicitly release notifiers to the old document here, 
     * or do your own housekeeping. Also called right before the application 
     * exits.
     */
    @:native("app_release_document_observable")
    public var appReleaseDocumentObservable :Observable;

    /**
     * Invoked each time a new document (song) is created or loaded, aka each 
     * time the result of renoise.song() is changed. Also called when the script 
     * gets reloaded (only happens with the auto_reload debugging tools), in 
     * order to connect the new script instance to the already running document.
     */
    @:native("app_new_document_observable")
    public var appNewDocumentObservable :Observable;

    /**
     * invoked each time the app's document (song) is successfully saved. 
     * renoise.song().file_name will point to the filename that it was saved to.
     */
    @:native("app_saved_document_observable")
    public var appSavedDocumentObservable :Observable;
    
    /**
     * Returns true if the given entry already exists, otherwise false.
     * @param name 
     * @return Bool
     */
    @:native("has_menu_entry")
    public function hasMenuEntry(name :String) : Bool;

    /**
     * Add a new menu entry as described above.
     * @param entry 
     */
    @:native("add_menu_entry")
    public function addMenuEntry(entry :MenuEntry) : Void;

    /**
     * Remove a previously added menu entry by specifying its full name.
     * @param name 
     */
    @:native("remove_menu_entry")
    public function removeMenuEntry(name :String) : Void;

    /**
     * Returns true when the given keybinging already exists, otherwise false.
     * @param name 
     * @return Bool
     */
    @:native("has_keybinding")
    public function hasKeybinding(name :String) : Bool;

    /**
     * Add a new keybinding entry as described above.
     * @param def 
     */
    @:native("add_keybinding")
    public function addKeybinding(def :Dynamic) : Void;

    /**
     * Remove a previously added key binding by specifying its name and path.
     * @param name 
     */
    @:native("remove_keybinding")
    public function removeKeybinding(name :String) : Void;

    /**
     * Returns true when the given mapping already exists, otherwise false.
     * @param name 
     * @return Bool
     */
    @:native("has_midi_mapping")
    public function hasMidiMapping(name :String) : Bool;

    /**
     * Add a new midi_mapping entry as described above.
     * @param def 
     */
    @:native("add_midi_mapping")
    public function addMidiMapping(def :Dynamic) : Void;

    /**
     * Remove a previously added midi mapping by specifying its name.
     * @param name 
     */
    @:native("remove_midi_mapping")
    public function removeMidiMapping(name :String) : Void;

    /**
     * Returns true when the given hook already exists, otherwise false.
     * @param category 
     * @param extTable 
     * @return Bool
     */
    @:native("has_file_import_hook")
    public function hasFileImportHook(category :String, extTable :Dynamic) : Bool;

    /**
     * Add a new file import hook as described above.
     * @param def 
     */
    @:native("add_file_import_hook")
    public function addFileImportHook(def :Dynamic) : Void;

    /**
     * Remove a previously added file import hook by specifying its category and
     * extension(s)
     * @param category 
     * @param extTable 
     */
    @:native("remove_file_import_hook")
    public function removeFileImportHook(category :String, extTable :Dynamic) : Void;

    /**
     * Returns true when the given function or method was registered as a timer.
     * @param cb 
     * @return Bool
     */
    @:native("has_timer")
    public function has_timer(cb : Void -> Void) : Bool;

    /**
     * Add a new timer as described above.
     * @param cb 
     * @param ms 
     */
    @:native("add_timer")
    public function add_timer(cb : Void -> Void, ms :Int) : Void;

    /**
     * Remove a previously registered timer.
     * @param cb 
     */
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