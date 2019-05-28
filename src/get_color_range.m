function color_range = get_color_range()

    red_min = 175;
    red_max = 255;
    green_min = 175;
    green_max = 255;
    yellowR_min = 175;
    yellowR_max = 255;
    yellowG_min = 150;
    yellowG_max = 255;
    blueG_min = 125;
    blueG_max = 255;
    blueB_min = 175;
    blueB_max = 255;
    orangeR_min = 175;
    orangeR_max = 255;
    orangeG_min = 95;
    orangeG_max = 255;

    keys = {'red_min', 'red_max', 'green_min', 'green_max', ...
    'yellowR_min', 'yellowR_max', 'yellowG_min', 'yellowG_max', ...
    'blueG_min', 'blueG_max', 'blueB_min', 'blueB_max', ...
    'orangeR_min', 'orangeR_max', 'orangeG_min', 'orangeG_max'};
    values = [red_min red_max green_min green_max yellowR_min yellowR_max yellowG_min yellowG_max blueG_min blueG_max blueB_min blueB_max orangeR_min orangeR_max orangeG_min orangeG_max];
    color_range = containers.Map(keys, values);

end