package grig.controller.bitwig;

import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.io.File;
import sys.FileSystem;

class Generator
{
    private static inline var NAME = 'name';
    private static inline var AUTHOR = 'author';
    private static inline var VERSION = 'version';
    private static inline var HARDWARE_VENDOR = 'hardwareVendor';
    private static inline var HARDWARE_MODEL = 'hardwareModel';
    private static inline var NUM_MIDI_IN_PORTS = 'numMidiInPorts';
    private static inline var NUM_MIDI_OUT_PORTS = 'numMidiOutPorts';
    private static inline var UUID = 'uuid';
    private static inline var DEVICE_NAME_PAIRS = 'deviceNamePairs';

    #if macro

    private static function getTypeRef(name:String):Ref<ClassType>
    {
        var definitionType = Context.getType(name);

        switch (definitionType) {
            default:
                return Context.error("Expected a ClassType", Context.currentPos());
            case TInst(cr, _):
                return cr;
        }
    }

    private static function checkMetadata(name:String, value:Null<String>):Void
    {
        if (value == null) {
            Context.error('Missing metadata @$name', Context.currentPos());
        }
    }

    private static function makeReturnFunction(name:String, value:String):Field
    {
        var fn:Function = { args: [] };
        fn.expr = { pos: Context.currentPos(), expr: EReturn({pos: Context.currentPos(), expr: EConst(CString(value))}) };
        var type:FieldType = FFun(fn);
        return { pos: Context.currentPos(), name: name, kind: type, access: [APublic, AOverload] };
    }

    private static function makeIntReturnFunction(name:String, value:String):Field
    {
        var fn:Function = { args: [] };
        fn.expr = { pos: Context.currentPos(), expr: EReturn({pos: Context.currentPos(), expr: EConst(CInt(value))}) };
        var type:FieldType = FFun(fn);
        return { pos: Context.currentPos(), name: name, kind: type, access: [APublic, AOverload] };
    }

    public static function extractArrayOfPairs(meta:MetadataEntry):Array<Array<String>>
    {
        var arrays = new Array<Array<String>>();
        if (meta.params == null || meta.params.length < 1) return null;
        switch (meta.params[0].expr) {
            case EArrayDecl(values):
                var subArray = new Array<String>();
                for (value in values) {
                    switch (value.expr) {
                        case EArrayDecl(subValues):
                            for (subValue in subValues) {
                                switch (subValue.expr) {
                                    case EConst(CString(s)):
                                        subArray.push(s);
                                    default:
                                        Context.warning('Array member not valid string in metadata', Context.currentPos());
                                }
                            }
                        default:
                            Context.warning('Malformed metadata array', Context.currentPos());
                            return [];
                    }
                }
                if (subArray.length != 2) {
                    Context.warning('Array not length of 2 in metadata', Context.currentPos());
                    return [];
                }
                arrays.push(subArray);
            default:
                Context.warning('Malformed metadata array', Context.currentPos());
                return [];
        }
        return arrays;
    }

    public static function generate(fields:Array<Field>):Void
    {
        var classType = Context.getLocalClass().get();
        var classPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: classType.name
        }
        var classComplexType = TPath(classPath);

        // First, make the wrapper class that inherits from ControllerExtension
        var wrapperTypeName = classType.name + 'Extension';
        var wrapperClassPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: wrapperTypeName
        }
        var definitionName = classType.name + 'ExtensionDefinition';
        var definitionClassPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: definitionName
        }
        var definitionComplexType = TPath(definitionClassPath);
        var extensionClass = macro class $wrapperTypeName extends com.bitwig.extension.controller.ControllerExtension {
            private var controller:$classComplexType;
            public function new(definition:$definitionComplexType, host:com.bitwig.extension.controller.api.ControllerHost) {
                super(definition, host);
            }
            overload public function init():Void {
                controller = new $classPath();
                var controllerHost:com.bitwig.extension.controller.api.ControllerHost = getHost();
                var host = new grig.controller.bitwig.Host(controllerHost);
                controller.startup(host);
            }            
            overload public function exit():Void {
                controller.shutdown();
            }
            overload public function flush():Void {
                controller.flush();
            }
        }
        extensionClass.pack = classType.pack;
        Context.defineType(extensionClass);

        // Now get the metadata for populating the definition class
        var name:Null<String> = null;
        var author:Null<String> = null;
        var version:Null<String> = null;
        var hardwareVendor:Null<String> = null;
        var hardwareModel:Null<String> = null;
        var numMidiInPorts:String = '0';
        var numMidiOutPorts:String = '0';
        var uuid:Null<String> = null;
        // @deviceNamePairs([["APC Key 25"], ["APC Key 25"], ["APC Key 25 MIDI 1"], ["APC Key 25 MIDI 1"]])
        var deviceNamePairs = new Array<Array<String>>();
        var metadata = classType.meta.get();
        for (metadatum in metadata) {
            if (metadatum.name == DEVICE_NAME_PAIRS) {
                deviceNamePairs = extractArrayOfPairs(metadatum);
                continue;
            }

            var val = grig.controller.Generator.extractMetadataValue(metadatum);
            if (val == null) continue;
            if (metadatum.name == NAME) {
                name = val;
            } else if (metadatum.name == AUTHOR) {
                author = val;
            } else if (metadatum.name == VERSION) {
                version = val;
            } else if (metadatum.name == HARDWARE_VENDOR) {
                hardwareVendor = val;
            } else if (metadatum.name == HARDWARE_MODEL) {
                hardwareModel = val;
            } else if (metadatum.name == NUM_MIDI_IN_PORTS) {
                numMidiInPorts = val;
            } else if (metadatum.name == NUM_MIDI_OUT_PORTS) {
                numMidiOutPorts = val;
            } else if (metadatum.name == UUID) {
                uuid = val;
            }
        }
        checkMetadata(NAME, name);
        checkMetadata(AUTHOR, author);
        checkMetadata(VERSION, version);
        checkMetadata(HARDWARE_VENDOR, hardwareVendor);
        checkMetadata(HARDWARE_MODEL, hardwareModel);
        checkMetadata(UUID, uuid);

        // Now make the definition class
        var definitionClass = macro class $definitionName extends com.bitwig.extension.controller.ControllerExtensionDefinition {
            overload public function getRequiredAPIVersion():Int {
                return 13;
            }
            overload public function createInstance(host:com.bitwig.extension.controller.api.ControllerHost):com.bitwig.extension.controller.ControllerExtension {
                return new $wrapperClassPath(this, host);
            }
            overload public function listAutoDetectionMidiPortNames(list:com.bitwig.extension.controller.AutoDetectionMidiPortNamesList,
                platformType:com.bitwig.extension.api.PlatformType):Void {
            }
        }

        definitionClass.fields.push(makeReturnFunction('getName', name));
        definitionClass.fields.push(makeReturnFunction('getAuthor', author));
        definitionClass.fields.push(makeReturnFunction('getVersion', version));
        definitionClass.fields.push(makeReturnFunction('getHardwareVendor', hardwareVendor));
        definitionClass.fields.push(makeReturnFunction('getHardwareModel', hardwareModel));
        definitionClass.fields.push(makeIntReturnFunction('getNumMidiInPorts', numMidiInPorts));
        definitionClass.fields.push(makeIntReturnFunction('getNumMidiOutPorts', numMidiOutPorts));

        var getUuidFn:Function = { args: [] };
        var getUuidExpr = { pos: Context.currentPos(), expr: EConst(CString(uuid)) };
        getUuidFn.expr = macro {
            return java.util.UUID.fromString($getUuidExpr);
        }
        var getUuidType:FieldType = FFun(getUuidFn);
        var getUuidField = { pos: Context.currentPos(), name: 'getId', kind: getUuidType, access: [APublic, AOverload] };
        definitionClass.fields.push(getUuidField);
        definitionClass.pack = classType.pack;

        Context.defineType(definitionClass);

        // Now to generate the meta inf that goes into the final jar file
        // to notify Bitwig of where the plugin lives
        var pack = classType.pack.copy();
        // If this is at root level, haxe will throw it in haxe.root
        if (pack.length == 0) pack = ['haxe', 'root'];
        pack.push(definitionName);
        var packString = pack.join('.') + '\n';
        var packDir = [Path.directory(Compiler.getOutput()), 'META-INF', 'services'];
        FileSystem.createDirectory(Path.join(packDir));
        packDir.push('com.bitwig.extension.ExtensionDefinition');
        var packFile = Path.join(packDir);
        File.saveContent(packFile, packString);
    }

#end
}