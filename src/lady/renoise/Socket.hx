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

package lady.renoise;

import lady.renoise.Osc.Bundle;
import lady.renoise.Osc.Message;
import haxe.extern.EitherType;

@:native("renoise.Socket")
extern class Socket
{
    /**
     * Creates a connected UPD or TCP server object. Use "localhost" to use your
     * system's default network address. Protocol can be 
     * renoise.Socket.PROTOCOL_TCP or renoise.Socket.PROTOCOL_UDP (by default 
     * TCP). When instantiation and connection succeed, a valid server object is
     * returned, otherwise "socket_error" is set and the server object is nil.
     * Using the create function with no server_address allows you to create a
     * server which allows connections to any address (for example localhost and
     * some IP)
     * @param serverAddress 
     * @param serverPort 
     * @param protocol 
     * @return SocketServer
     */
    @:native("create_server")
    public static function createServer(serverAddress :String, serverPort :Int, protocol :SocketProtocol) : SocketServer;

    /**
     * Create a connected UPD or TCP client. Protocol can be 
     * renoise.Socket.PROTOCOL_TCP or renoise.Socket.PROTOCOL_UDP (by default 
     * TCP) Timeout is the time to wait until the connection is established 
     * (1000 ms by default). When instantiation and connection succeed, a valid 
     * client object is returned, otherwise "socket_error" is set and the client 
     * object is nil
     * @param serverAddress 
     * @param serverPort 
     * @param protocol 
     * @return SocketClient
     */
    @:native("create_client")
    public static function createClient(serverAddress :String, serverPort :Int, protocol :SocketProtocol) : SocketClient;
}

extern class SocketBase
{
    /**
     * Returns true when the socket object is valid and connected. Sockets can 
     * manually be closed (see socket:close()). Client sockets can also actively 
     * be closed/refused by the server. In this case the client:receive() calls 
     * will fail and return an error.
     */
    @:native("is_open")
    public var isOpen : Bool;

    /**
     * The socket's resolved local address (for example "127.0.0.1" when a 
     * socket is bound to "localhost")
     */
    @:native("local_address")
    public var localAddress : String;

    /**
     * The socket's local port number, as specified when instantiated.
     */
    @:native("local_port")
    public var localPort : Int;

    /**
     * Closes the socket connection and releases all resources. This will make 
     * the socket useless, so any properties, calls to the socket will result in 
     * erro. Can be useful to explicitly release a connection without waiting 
     * for the dead object to be garbage collected, or if you want to actively 
     * refuse a connection.
     */
    public function close() : Void;
}

extern class SocketClient extends SocketBase
{
    /**
     * Address of the socket's peer, the socket address this client is connected
     * to.
     */
    @:native("peer_address")
    public var peerAddress : String;

    /**
     * Port of the socket's peer, the socket this client is connected to.
     */
    @:native("peer_port")
    public var peerPort : Int;

    /**
     * Send a message string (or OSC messages or bundles) to the connected 
     * server. When sending fails, "success" return value will be false and 
     * "error_message" is set, describing the error in a human readable format. 
     * NB: when using TCP instead of UDP as protocol for OSC messages, !no! SLIP 
     * encoding and no size prefixing of the passed OSC data will be done here. 
     * So, when necessary, do this manually by your own please.
     * @param message 
     * @return Bool
     */
    public function send(message :EitherType<Message, Bundle>) : Bool;

    /**
     * Receive a message string from the the connected server with the given 
     * timeout in milliseconds. Mode can be one of "line", "all" or a 
     * number > 0, like Lua's io.read. \param timeout can be 0, which is useful 
     * for receive("*all"). This will only check and read pending data from the 
     * sockets queue.
     * @param mode 
     * @param timeoutMs 
     * @return String
     */
    public function receive(mode :Dynamic, timeoutMs :Int) : String;
}

extern class SocketServer extends SocketBase
{
    /**
     * Returns true while the server is running (the server is up and running)
     */
    @:native("is_running")
    public var isRunning : Bool;

    /**
     * Start running the server by specifying a class or table which defines the 
     * callback functions for the server (see "callbacks" below for more info).
     * 
     * https://files.renoise.com/xrnx/documentation/Renoise.Socket.API.lua.html
     * 
     * @param notifierTableOrCall 
     */
    public function run(notifierTableOrCall : Dynamic) : Void;

    /**
     * Stop a running server.
     */
    public function stop() : Void;

    /**
     * Suspends the calling thread by the given timeout, and calls the server's 
     * callback methods as soon as something has happened in the server while 
     * waiting. Should be avoided whenever possible.
     * @param timeoutMs 
     */
    public function wait(timeoutMs :Int) : Void;
}

@:native("renoise.Socket")
extern enum abstract SocketProtocol(Int)
{
    @:native("PROTOCOL_TCP")
    var TCP;
    @:native("PROTOCOL_UDP")
    var UDP;
}