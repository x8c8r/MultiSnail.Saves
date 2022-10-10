
// Speedhack
if keyboard_check(vk_control)
    if keyboard_check(ord("S"))
        global.sx_speed--
if keyboard_check(vk_shift)
    if keyboard_check(ord("S"))
        global.sx_speed++
if keyboard_check(ord("~"))    
    if keyboard_check(ord("S"))
        global.sx_speed = 60
if (global.sx_speed <= 9)
    global.sx_speed = 10
game_set_speed(global.sx_speed, gamespeed_fps)