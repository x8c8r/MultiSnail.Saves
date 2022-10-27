// name ily fr

using GmmlPatcher;
using GmmlHooker;
using UndertaleModLib;
using UndertaleModLib.Models;

namespace MultiSnailSaves;

public class Main : IGameMakerMod {

    public static void ReplaceBuiltInFunction(string name, string og_name, string gml, ushort arguments, UndertaleData data)
    {
        UndertaleCode hookCode = data.CreateLegacyScript(name, gml, arguments).Code;

        foreach (UndertaleCode dataCode in data.Code)
        {
            if (dataCode.ParentEntry is not null || dataCode == hookCode)
                continue;
            
            data.HookAsm(dataCode.Name.Content, (code, locals) => {
                AsmCursor cursor = new(data, code, locals);
                while (cursor.GotoNext($"call.i {og_name}(argc={arguments})"))
                    cursor.Replace($"call.i {name}(argc={arguments})");
            });
        }
    }

    public void Load(int audioGroup, UndertaleData data, ModData currentMod) {
        if(audioGroup != 0) return;

        data.HookCode("gml_Object_obj_persistent_Create_0", @"
        global.save_directory = game_save_id
        if parameter_count() > 1
        {
            var i;
            for (i = 0; i < parameter_count(); i += 1)
            {
                p_string[i] = parameter_string(i + 1);
                if p_string[i] == ""-saveloc""
                {
                    savelocparameter = parameter_string(i + 2)
                    global.save_directory = game_save_id + ""Instances/"" + savelocparameter + ""/""
                    show_debug_message(""Save Directory: "" + global.save_directory)
                }
            }
        }
        #orig#()");

        ReplaceBuiltInFunction("_file_text_open_write", "file_text_open_write", @"if (string_count(working_directory, argument0) == 0)
            return file_text_open_write(global.save_directory + argument0)
        return file_text_open_write(argument0)", 1, data);
        ReplaceBuiltInFunction("_file_text_open_read", "file_text_open_read", @"if (string_count(working_directory, argument0) == 0)
            return file_text_open_read(global.save_directory + argument0)
        return file_text_open_read(argument0)", 1, data);
        ReplaceBuiltInFunction("_file_exists", "file_exists", @"if (string_count(working_directory, argument0) == 0)
            return file_exists(global.save_directory + argument0)
        return file_exists(argument0)", 1, data);
        ReplaceBuiltInFunction("_ini_open", "ini_open", @"if (string_count(working_directory, argument0) == 0)
            return ini_open(global.save_directory + argument0)
        return ini_open(argument0)", 1, data);     
    }
}
