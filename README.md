# grig.controller

[![pipeline status](https://gitlab.com/haxe-grig/grig.controller/badges/main/pipeline.svg)](https://gitlab.com/haxe-grig/grig.controller/commits/main)
[![Build Status](https://travis-ci.org/osakared/grig.controller.svg?branch=main)](https://travis-ci.org/osakared/grig.controller)
[![Gitter](https://badges.gitter.im/haxe-grig/Lobby.svg)](https://gitter.im/haxe-grig/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

See the [haxe grig documentation](https://grig.tech/)


```
haxe --run Maven.hx
haxe doc.hxml
lix run dox -i bin/ -o dist/
```

### Features

| Daw           | Midi IO | OSC IO | Clip Launcher | Tracker |
| ------------- | ------- | ------ | ------------- | ------- |
| Bitwig        | X       |        | X             |         |

### Planned support

* Dummy/test
* Bitwig (in progress)
* FL Studio (planned)
* Reaper (planned)
* Renoise (planned)
* Ableton Live (planned, but technically unlikely to work)

### Metadata

These metadata are supported (and, depending on the target, required) on controllers which implement `grig.controller.Controller`:

`@name`

Name of the controller

`@author`

Author's name (such as github username)

`@version`

Version number, such as `1.0`

`@uuid`

Unique uuid id for plugin.

`@hardwareVendor`

Brand name of controller

`@hardwareModel`

Model name of controller

`@numMidiInPorts`

Number of midi in ports. Defaults to 0.

`@numMidiOutPorts`

Number of midi out ports. Defualts to 0.

`@deviceNamePairs`

Array of 2-length arrays of strings representing other pairs of midi input/output hardware names. Used by Bitwig.