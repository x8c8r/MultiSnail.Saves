function scr_load_empty_game() //gml_Script_scr_load_empty_game
{
    global.save_deaths = 0
    global.save_button_presses_in_tutorial = 0
    global.save_restarts_by_ai_in_tutorial = 0
    global.save_ai_handicap = 0
    global.save_played_sounds = ds_list_create()
    global.save_played_locakeys = ds_list_create()
    global.save_difficulty = 0
    global.save_target_deaths = 0
    global.save_target_deaths_in_this_level = 0
    global.save_difficulty_selection_unlocked = 0
    global.save_levels_you_have_to_beat_till_difficulty_can_be_increased_again = -1
    global.save_speedrun_timer_game = 0
    global.save_speedrun_timer_chapter = 0
    global.save_speedrun_current_chapter = -1
    global.save_speedrun_timer_level = 0
    global.save_exploration_mode = 0
    global.save_collected_exploration_points = ds_list_create()
    global.save_game_speed = 1
    global.save_speedrun_training_mode = 0
    global.save_unlocked_dialogs = ds_list_create()
    global.save_equipped_hat = -1
    global.save_heart_fixed = 0
    global.save_final_final_credits_reached = 0
    global.save_pump_is_inverted = 0
    global.save_speedrun_is_still_legit = 1
    global.save_anger_game_level = 1
    global.save_anger_game_xp = 0
    global.save_auto_difficulty = 1
    global.save_fixed_jump_height = 0
    global.save_id = 0
    scr_level_dat_ini()
    if instance_exists(obj_start_screen)
        global.gotolevel_after_start_screen = 29
    room_speed = (global.save_game_speed * 60)
    return;
}

function scr_load_game() //gml_Script_scr_load_game
{
    gml_Script_scr_load_empty_game_M()
    ds_list_room_order = ds_list_create()
    li_level_ids_temp = ds_list_create()
    if (!gml_Script_scr_save_game_exists_M())
        return;
    slot_prefix = gml_Script_scr_get_save_slot_prefix(global.active_save_slot)
    usealtfile = 0
    if (!(file_exists((global.save_directory + slot_prefix + "SaavoGame23-2.sav"))))
        usealtfile = 1
    else if (!(file_exists(((global.save_directory + slot_prefix + "_alt_") + "SaavoGame23-2.sav"))))
        usealtfile = 0
    else
    {
        file = file_text_open_read((global.save_directory + slot_prefix + "SaavoGame23-2.sav"))
        saveid_normal = file_text_read_real(file)
        file_text_close(file)
        file = file_text_open_read(((global.save_directory + slot_prefix + "_alt_") + "SaavoGame23-2.sav"))
        saveid_alt = file_text_read_real(file)
        file_text_close(file)
        if (saveid_normal > saveid_alt)
            usealtfile = 0
        else
            usealtfile = 1
    }
    if usealtfile
        file = file_text_open_read(((global.save_directory + slot_prefix + "_alt_") + "SaavoGame23-2.sav"))
    else
        file = file_text_open_read((global.save_directory + slot_prefix + "SaavoGame23-2.sav"))
    save_file_version = ""
    global.save_id = file_text_read_real(file)
    file_text_readln(file)
    while (!file_text_eof(file))
    {
        section_header = file_text_read_string(file)
        file_text_readln(file)
        switch section_header
        {
            case "Game Version":
                save_file_version = file_text_read_string(file)
                file_text_readln(file)
                rooroom = empty_start_room
                iiii = 0
                while (room_next(rooroom) != -1)
                {
                    ds_list_add(ds_list_room_order, rooroom)
                    rooroom = room_next(rooroom)
                    ds_list_add(li_level_ids_temp, (iiii + 5))
                    iiii++
                }
                scr_room_ids_downward_compability()
                break
            case "Room":
                loadroom = file_text_read_real(file)
                if (save_file_version != "1.42" || loadroom == 9)
                    loadroom = 144
                if instance_exists(obj_start_screen)
                    global.gotolevel_after_start_screen = loadroom
                else
                    scr_fade_to_room(loadroom)
                file_text_readln(file)
                break
            case "Deaths":
                global.save_deaths = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Difficulty":
                global.save_difficulty = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Played Voice Lines":
                scr_ld_list_string(global.save_played_locakeys)
                break
            case "Difficulty Settings Unlocked":
                global.save_difficulty_selection_unlocked = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Level Data: Deaths":
                scr_ld_list_room_data(global.li_lvldat_deaths)
                break
            case "Level Data: Playtime":
                scr_ld_list_room_data(global.li_lvldat_playtime)
                break
            case "Level Data: Unlocked":
                scr_ld_list_room_data(global.li_lvldat_unlocked)
                break
            case "Level Data: Beaten On Difficulty":
                scr_ld_list_room_data(global.li_lvldat_beaten_on_difficulty)
                break
            case "Level Data: Beaten On Difficulty Underwater":
                scr_ld_list_room_data(global.li_lvldat_beaten_on_difficulty_underwater)
                break
            case "Level Data: Autodiff-Playtime":
                scr_ld_list_room_data(global.li_lvldat_autodiff_playtime)
                break
            case "Level Data: Autodiff-Deaths":
                scr_ld_list_room_data(global.li_lvldat_autodiff_difficulty)
                break
            case "Autodiff Levels Till Increase":
                global.save_levels_you_have_to_beat_till_difficulty_can_be_increased_again = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Timer Game":
                global.save_speedrun_timer_game = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Timer Chapter":
                global.save_speedrun_timer_chapter = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Current Chapter":
                global.save_speedrun_current_chapter = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Timer Level":
                global.save_speedrun_timer_level = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Exploration Mode":
                global.save_exploration_mode = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Collected Exploration Points":
                scr_ld_list_string(global.save_collected_exploration_points)
                break
            case "Game Speed":
                global.save_game_speed = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Training Mode":
                global.save_speedrun_training_mode = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Unlocked Dialogs":
                scr_ld_list_string(global.save_unlocked_dialogs)
                break
            case "Hat":
                global.save_equipped_hat = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Heart Fixed":
                global.save_heart_fixed = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Final Credits Reached":
                global.save_final_final_credits_reached = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Pump Inverted":
                global.save_pump_is_inverted = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Speedrun Is Still Legit":
                global.save_speedrun_is_still_legit = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Anger Game Level":
                global.save_anger_game_level = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Anger Game XP":
                global.save_anger_game_xp = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Auto Difficulty":
                global.save_auto_difficulty = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Fixed Jump Height":
                global.save_fixed_jump_height = file_text_read_real(file)
                file_text_readln(file)
                break
        }

    }
    file_text_close(file)
    ds_list_destroy(li_level_ids_temp)
    room_speed = (global.save_game_speed * 60)
    ds_list_destroy(ds_list_room_order)
    return;
}

