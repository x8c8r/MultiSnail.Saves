using GmmlPatcher;
using GmmlHooker;
using UndertaleModLib;

namespace SnailXacks;

public class Main : IGameMakerMod {

    public void Load(int audioGroup, UndertaleData data, ModData currentMod) {
        if(audioGroup != 0) return;

        data.HookCode("gml_Object_obj_levelstyler_Create_0", @"
        #orig#()
        global.sx_speedStart = 60
        ");

        data.HookCode("gml_Object_obj_levelstyler_Step_0", @"
        #orig#()
        if keyboard_check(vk_control)
            if keyboard_check(ord(""S""))
                global.sx_speedStart--
        if keyboard_check(vk_shift)
            if keyboard_check(ord(""S""))
                global.sx_speedStart++
             
        if (global.sx_speedStart <= 9)
            global.sx_speedStart = 10
        if (global.sx_speedStart >= 241)
            global.sx_speedStart = 240
        game_set_speed(global.sx_speedStart, gamespeed_fps)
        ");

    }
}
