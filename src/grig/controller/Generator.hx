package grig.controller;

import haxe.macro.Expr;
import haxe.macro.Context;

/**
 * Macro-based generator for controllers
 */
class Generator
{
#if macro

    public static function verifyAbsence(fieldName:String, fields:Array<Field>):Void
    {
        for (field in fields) {
            if (field.name == fieldName) {
                Context.error('grig.controller: Field $fieldName will conflict with macro generated code', Context.currentPos());
            }
        }
    }

    public static function extractMetadataValue(meta:MetadataEntry):Null<String>
    {
        if (meta.params == null || meta.params.length < 1) return null;
        return switch (meta.params[0].expr) {
            case EConst(CString(s)): return s;
            case EConst(CInt(i)): return i;
            default: null;
        }
    }

    public static function build():Array<Field>
    {
        var fields = Context.getBuildFields();

        // Switch which generator to use based on defines
        #if GRIG_CONTROLLER_STANDALONE
        grig.controller.standalone.Generator.generate(fields);
        #elseif GRIG_CONTROLLER_BITWIG
        grig.controller.bitwig.Generator.generate(fields);
        #end

        return fields;
    }

#end
}