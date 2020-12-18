/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any peon obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit peons to whom the Software is furnished to do so,
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

package fire.fromRenoise;

import renoise.Renoise;
import fire.util.Signal1;
import renoise.ds.ReadOnlyTableArray;

class ScaleMode
{
    public var index : Signal1<Int>;
    public var available : ReadOnlyTableArray<String>;

    public function new() : Void
    {
        this.available = Renoise.song().selectedInstrument.triggerOptions.availableScaleModes;
        this.index = new Signal1(getIndex());
        _ignoreNotifier = true;
        this.init();
    }

    private function init() : Void
    {
        Renoise.song().selectedInstrument.triggerOptions.scaleModeObservable.addNotifier(() -> {
            if(!_ignoreNotifier) {
                this.index.value = getIndex();
            }
            _ignoreNotifier = false;
        });
    }

    public function prev() : Void
    {
        if(this.index.value > 1) {
            _ignoreNotifier = true;
            this.index.value--;
            Renoise.song().selectedInstrument.triggerOptions.scaleMode = available[this.index.value];
        }
    }

    public function next() : Void
    {
        if(this.index.value < available.length) {
            _ignoreNotifier = true;
            this.index.value++;
            Renoise.song().selectedInstrument.triggerOptions.scaleMode = available[this.index.value];
        }
    }

    private function getIndex() : Int
    {
        var index = 1;
        var current = Renoise.song().selectedInstrument.triggerOptions.scaleMode;
        while(index <= this.available.length) {
            var scale = this.available[index];
            if(current == scale) {
                return index;
            }
            index++;
        }
        return -1;
    }

    private var _ignoreNotifier : Bool;
}