package grig.controller.standalone;

import grig.osc.UdpPacketListener;
import grig.osc.Server;

class Host implements grig.controller.Host
{
    private var volumeChangeCallbacks:Array<(Float)->Void>;

    public function new()
    {
    }

    // Make these all return promises
    public function createOscServer(port:Int):grig.osc.Server
    {
        var socket = new UdpPacketListener();
        socket.bind('0.0.0.0', port);
        var server = new Server(socket);
        return server;
    }

    public function createOscClient(host:String, port:Int):grig.osc.Client
    {
        var sender = new grig.osc.UdpPacketSender(host, port);
        return new grig.osc.Client(sender);
    }

    public function registerVolumeChangeCallback(callback:(volume:Float)->Void):Void
    {
        volumeChangeCallbacks.push(callback);
    }

    public function sendVolumeChangeUpdate(volume:Float):Void
    {
        for (callback in volumeChangeCallbacks) {
            callback(volume);
        }
    }
}