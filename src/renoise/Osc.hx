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

package renoise;

import haxe.extern.EitherType;

extern class Osc
{
    /**
     * De-packetizing raw (socket) data to OSC messages or bundles converts the 
     * binary data to an OSC message or bundle. If the data does not look like 
     * an OSC message, or the message contains erro, nil is returned as fit 
     * argument and the second return value will contain the error. If 
     * de-packetizing was successful, either a renoise.Osc.Bundle or Message 
     * object is returned. Bundles may contain multiple messages or nested 
     * bundles.
     * @param data 
     * @return EitherType<Message, Bundle>
     */
    @:native("from_binary_data")
    public static function fromBinaryData(data :String) : EitherType<Message, Bundle>;

    /**
     * Create a new OSC message with the given pattern and optional arguments. 
     * When arguments are specified, they must be specified as a table of:
     * { tag="X", value=SomeValue }
     * @param pattern 
     * @param arguments 
     * @return Message
     */
    @:native("Message")
    public static function createMessage(pattern :String, arguments :OscArgs) : Message;

    /**
     * Create a new bundle by specifying a time-tag and one or more messages. If 
     * you do not know what to do with the time-tag, use os.clock(), which simply 
     * means "now". Messages must be renoise.Osc.Message objects. Nested bundles 
     * (bundles in bundles) are right now not supported.
     * @param pattern 
     * @param arguments 
     * @return Bundle
     */
    @:native("Bundle")
    public static function createBundle(pattern :String, arguments :OscArgs) : Bundle;
}

extern class Message
{
    /**
     * The message pattern (e.g. "/renoise/transport/start")
     */
    public var pattern (default, null) : String;

    /**
     * Table of {tag="X", value=SomeValue} that represents the message arguments. 
     * see renoise.Osc.Message "create" for more info.
     */
    public var arguments (default, null) : OscArgs;

    /**
     * Raw binary representation of the messsage, as needed when e.g. sending 
     * the message over the network through sockets.
     */
    @:native("binary_data")
    public var binaryData (default, null) : String;
}

extern class Bundle
{
    /**
     * Time value of the bundle.
     */
    public var timetag (default, null) : Int;

    /**
     * Access to the bundle elements (table of messages or bundle objects)
     */
    public var elements (default, null) : OscArgs;

    /**
     * Raw binary representation of the bundle, as needed when e.g. sending the 
     * message over the network through sockets.
     */
    @:native("binary_data")
    public var binaryData (default, null) : String;
}

@:native("table")
private extern class __OscArgs__
{
    public static function create() : OscArgs;
    public function insert(data :Dynamic) : Void;
}

@:forwardStatics(create)
abstract OscArgs(__OscArgs__)
{
    inline public function addTagValue(tag :String, value :Dynamic) : Void
    {
        untyped _hx_insert_tag_value(this, tag, value);
    }
}