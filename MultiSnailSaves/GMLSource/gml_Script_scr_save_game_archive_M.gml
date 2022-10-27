    if scr_save_game_exists()
    {
        date = date_current_datetime()
        year = date_get_year(date)
        month = date_get_month(date)
        day = date_get_day(date)
        hour = date_get_hour(date)
        sec = date_get_second(date)
        strDate = ((((((((string(year) + "-") + string(month)) + "-") + string(day)) + "-") + string(hour)) + "-") + string(sec))
        slot_prefix = gml_Script_scr_get_save_slot_prefix(global.active_save_slot)
        if file_exists((global.save_directory + slot_prefix + "SaavoGame23-2.sav"))
            file_rename((global.save_directory + slot_prefix + "SaavoGame23-2.sav"), (((global.save_directory + slot_prefix + "SaveFileBackup-") + strDate) + ".sav"))
        if file_exists(((global.save_directory + slot_prefix + "_alt_") + "SaavoGame23-2.sav"))
            file_rename(((global.save_directory + slot_prefix + "_alt_") + "SaavoGame23-2.sav"), (((global.save_directory + slot_prefix + "SaveFileBackup_alt_-") + strDate) + ".sav"))
    }
    return;