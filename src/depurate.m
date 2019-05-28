function depurate(vid, galileo)
    debug_color_pixels = false;
    debug_color = 'all';
    debug_just_video = false;
    color_range = get_color_range();

    if(~debug_just_video)
        if  strcmp(debug_color, 'all')
            press_all_buttons(vid, galileo, color_range, debug_color_pixels);
        elseif  strcmp(debug_color, 'green')
            press_buttons_green(vid, galileo, color_range, debug_color_pixels);
        elseif  strcmp(debug_color, 'red')
            press_buttons_red(vid, galileo, color_range, debug_color_pixels);
        elseif  strcmp(debug_color, 'blue')
            press_buttons_blue(vid, galileo, color_range, debug_color_pixels);
        elseif  strcmp(debug_color, 'orange')
            press_buttons_orange(vid, galileo, color_range, debug_color_pixels);
        elseif  strcmp(debug_color, 'yellow')
            press_buttons_yellow(vid, galileo, color_range, debug_color_pixels);
        end
    end
end