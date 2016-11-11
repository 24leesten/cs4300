function safe = CS4300_update_safe(visited, stench, breezes)
% CS4300_update_frontier - update the frontier
% On input:
%     visited (4x4 vector): represents the visited cells
%     stenches (4x4 vector): represents the visited cells
%     breexes (4x4 vector): represents the visited cells
% On output:
%     frontier (4x4 vector): represents the visited cells
%         0: visited
%         1: frontier
%         -1: unvisited
% Call:
% frontier = CS4300_update_safe()
% new_state = [1 1 0]
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     FAll 2016
%

safe = visited;

% go through and make all the cells that are adjacent to a 0 frontier cells
for r = 1:4
    row = fix_y(r);
    for col =1:4
        if visited(row, col) == 1 && stench(row, col) == 0 && breezes(row,col) == 0
            NORTH = row - 1;
            WEST = col - 1;
            SOUTH = row + 1;
            EAST = col + 1;
            if(NORTH > 0)
                safe(NORTH, col) = 1;
            end
            if(WEST > 0)
                safe(row, WEST) = 1;
            end
            if(SOUTH < 5)
                safe(SOUTH, col) = 1;
            end
            if(EAST < 5)
                safe(row, EAST) = 1;
            end 
        end
    end
end