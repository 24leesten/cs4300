function frontier = CS4300_update_frontier(visited)
% CS4300_update_frontier - update the frontier
% On input:
%     visited (4x4 vector): represents the visited cells
% On output:
%     frontier (4x4 vector): represents the visited cells
%         0: visited
%         1: frontier
%         -1: unvisited
% Call:
% visited = -ones(4,4);
% visited(4,1) = 0;
% frontier = CS4300_update_frontier(visited)
% new_state = [1 1 0]
%
% Author:
%     Ryan Keepers
%     Leland Stenquist
%     UU
%     FAll 2016
%

frontier = (visited-1)/2;

% go through and make all the cells that are adjacent to a 0 frontier cells
for r = 1:4
    row = fix_y(r);
    for col =1:4
        if visited(row, col) == 1
            NORTH = row - 1;
            WEST = col - 1;
            SOUTH = row + 1;
            EAST = col + 1;
            if(NORTH > 0 && frontier(NORTH,col) == -1)
                frontier(NORTH, col) = 1;
            end
            if(WEST > 0 && frontier(row,WEST) == -1)
                frontier(row, WEST) = 1;
            end
            if(SOUTH < 5 && frontier(SOUTH,col) == -1)
                frontier(SOUTH, col) = 1;
            end
            if(EAST < 5 && frontier(row,EAST) == -1)
                frontier(row, EAST) = 1;
            end 
        end
    end
end