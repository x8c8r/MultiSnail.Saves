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