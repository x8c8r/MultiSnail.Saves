using GmmlPatcher;
using GmmlHooker;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Decompiler;
using TSIMPH;

namespace SX;

public class Main : IGameMakerMod {

            // stealing
        public static Dictionary<string, string> GMLkvp = new Dictionary<string, string>();
        public static GlobalDecompileContext? GDC;

        public static bool LoadGMLFolder(string gmlFolder)
        {
            return GMLkvp.LoadGMLFolder(gmlFolder);
        }

        public static void LoadGMLRecursive(string gmlFolder, string skip = "")
        {
            if(gmlFolder != skip)
                LoadGMLFolder(gmlFolder);
            
            string[] directories = Directory.GetDirectories(gmlFolder);

            for (int i = 0; i < directories.Length; i++)
            {
                LoadGMLFolder(directories[i]);
                LoadGMLRecursive(directories[i], directories[i]);
            }
        }

    public void Load(int audioGroup, UndertaleData data, ModData currentMod) {
        if(audioGroup != 0) return;

        string gmlFolder = Path.Combine(currentMod.path, "GMLSource");

        LoadGMLRecursive(gmlFolder);

        UndertaleGameObject sxManager = new UndertaleGameObject();
        sxManager.Name = data.Strings.MakeString("obj_sxmanager");
        sxManager.Sprite = data.Sprites.ByName("spr_player");
        sxManager.Persistent = true;

        sxManager.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
            .AppendGmlSafe(GMLkvp["gml_Object_obj_sxmanager_Create"], data);

        sxManager.EventHandlerFor(EventType.Step, EventSubtypeStep.Step, data.Strings, data.Code, data.CodeLocals)
            .AppendGmlSafe(GMLkvp["gml_Object_obj_sxmanager_Step_0"], data);

        data.GameObjects.Add(sxManager);

        //name is cool
        UndertaleRoom menu = data.Rooms.First(room => room.Name.Content == "main_menu_dark");
        menu.AddObjectToLayer(data, "obj_sxmanager", "Player").X -= 180;

    }
}
