package grig.controller.bitwig;

class Transport implements grig.controller.Transport
{
    private var transport:com.bitwig.extension.controller.api.Transport;

    public function new(transport_:com.bitwig.extension.controller.api.Transport)
    {
        transport = transport_;
    }

    public function play()
    {
        transport.play();
    }

    public function pause()
    {
        transport.stop();
    }

    public function stop()
    {
        transport.stop();
    }

    public function record()
    {
        transport.record();
    }

    public function playPause()
    {
        transport.togglePlay();
    }

    public function tapTempo()
    {
        transport.tapTempo();
    }
}