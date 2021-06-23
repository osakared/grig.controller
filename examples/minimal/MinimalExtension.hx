package;

import grig.controller.Host;

@name("minimal")
@author("pinkboi")
@version("0.0.1")
@uuid("74987444-CC14-4157-AA93-A845A54DA8DF")
@hardwareVendor("Acme")
@hardwareModel("Minimizer")
class MinimalExtension implements grig.controller.Controller
{
    var host:Host;

    public function new()
    {
    }

    public function startup(host:Host)
    {
        this.host = host;
        host.showMessage('startup() called');
    }

    public function shutdown()
    {
        host.showMessage('shutdown() called');
    }

    public function flush()
    {
    }
}