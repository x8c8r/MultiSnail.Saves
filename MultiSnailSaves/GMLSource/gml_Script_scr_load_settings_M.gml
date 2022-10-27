
    file = file_text_open_read(global.save_directory + "SettoIngs23-2.set")
    save_file_version = ""
    while (!file_text_eof(file))
    {
        section_header = file_text_read_string(file)
        file_text_readln(file)
        switch section_header
        {
            case "Game Version":
                save_file_version = file_text_read_string(file)
                file_text_readln(file)
                break
            case "Gamepad Rumble":
                global.setting_gamepad_rumble = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Volume Master":
                global.setting_volume_master = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Volume Voice":
                global.setting_volue_voice = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Volume Music":
                global.setting_volue_music = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Volume SoundFx":
                global.setting_volue_fx = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Post Processing":
                global.setting_post_processing = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Visual Detail":
                global.setting_visual_details = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Subtitles":
                global.setting_subtitles = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Window Mode":
                global.setting_window_mode = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Text Language":
                global.setting_loca_text = file_text_read_string(file)
                file_text_readln(file)
                break
            case "Audio Language":
                global.setting_loca_voice = file_text_read_string(file)
                file_text_readln(file)
                break
            case "Screenshake":
                global.setting_screenshake = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Subtitle Size":
                global.setting_subtitle_size = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Gamepad Dead Zones":
                global.setting_gp_dead_zones = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Speedrun Timer":
                global.setting_speedrun_timer_game = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Chapter Timer":
                global.setting_speedrun_timer_chapter = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Level Timer":
                global.setting_speedrun_timer_level = file_text_read_real(file)
                file_text_readln(file)
                break
            case "V-Sync":
                global.setting_vsync = file_text_read_real(file)
                file_text_readln(file)
                break
            case "AI Predictions":
                global.setting_show_ai_predictions = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Timing Method":
                global.setting_timing_method = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Sleep Margin":
                global.setting_sleep_margin = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Show FPS":
                global.setting_speedrun_show_fps = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Color Scheme":
                global.setting_color_scheme = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Squid Opacity":
                global.setting_squid_opacity = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Squid Stay In Back":
                global.setting_squid_stay_in_background = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Squid Facial Expessions":
                global.setting_squid_facial_expressions = file_text_read_real(file)
                file_text_readln(file)
                break
            case "Font Nr":
                global.setting_font_nr = file_text_read_real(file)
                file_text_readln(file)
                break
        }

    }
    file_text_close(file)
    audio_master_gain((global.setting_volume_master * global.setting_volume_master))
    audio_group_set_gain(1, (global.setting_volue_fx * global.setting_volue_fx), 0)
    audio_group_set_gain(2, (global.setting_volue_music * global.setting_volue_music), 0)
    scr_set_window_mode(global.setting_window_mode)
    display_reset(0, global.setting_vsync)
    if (global.setting_timing_method == 2)
        display_set_timing_method(1)
    else
        display_set_timing_method(global.setting_timing_method)
    display_set_sleep_margin(global.setting_sleep_margin)
    return;

