package;

import grig.controller.Host;

@name("minimal")
@author("pinkboi")
@version("0.0.1")
@uuid("c3f15e69-d773-4873-9e9f-b3f9a27f2878")
@hardwareVendor("nonexistent")
@hardwareModel("nonexistent")
class MinimalExtension implements grig.controller.Controller
{
    var host:Host;

    public function new()
    {
    }

    public function startup(host_:Host)
    {
        host = host_;

        host.showMessage('startup() called');
    }

    public function shutdown()
    {
        host.showMessage('shutdown() called');
    }
}