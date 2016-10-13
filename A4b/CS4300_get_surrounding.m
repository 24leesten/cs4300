function surroundings = CS4300_get_surrounding(x,y,p)

% stench or breeze

north = 0;
south = 0;
east = 0;
west = 0;

if(p > 0)
    p_ind = p + 5;
elseif(p < 0)
    p_ind = p - 5;
end

% retrieve const values for locations 
if x < 4
    north = CS4300_pos_consts(x,(y+1),p_ind);
end
if x > 1
    south = CS4300_pos_consts(x,(y-1),p_ind);
end
if y < 4
    east = CS4300_pos_consts((x+1),y,p_ind);
end
if y > 1
    west = CS4300_pos_consts((x-1),y,p_ind);
end

surroundings = [east north west south];