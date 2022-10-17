-module(gol).
-export([new/2, query/3, print/1, demo_grid/0, count_neighbours/3, game_logic/2, step_cell/3, simulate/1, run_simulation/2, end_simulation/0, clear_screen/0]).

-record(grid, {height = 10, width = 10, rows}).
-record(transition, {y, x, state}).

mod(X, Y) when X > 0 -> X rem Y;
mod(X, Y) when X < 0 -> Y + X rem Y;
mod(0, _Y) -> 0.

new(Height, Width) ->
    Column = array:new(Height),
    Array2d = array:map(fun(_X, _T) -> array:new([{size, Width}, {fixed, true}, {default, empty}]) end, Column),
    #grid{height = Height, width = Width, rows = Array2d}.

query(Grid, X, Y) ->
    Row = array:get(mod(Y, Grid#grid.height), Grid#grid.rows),
    array:get(mod(X, Grid#grid.width), Row).


assign(Grid, X, Y, State) ->
    Row = array:get(mod(Y, Grid#grid.height), Grid#grid.rows),
    UpdatedRow = array:set(mod(X, Grid#grid.width), State, Row),
    Rows = array:set(mod(Y, Grid#grid.height), UpdatedRow, Grid#grid.rows),
    Grid#grid{rows = Rows}.

draw(Value) ->
    case Value of
        empty -> "-";
        alive -> "*"
    end.

count_neighbours(Grid, X, Y) ->
    N = query(Grid, Y + 1, X),      %North
    NE = query(Grid, Y + 1, X + 1), %North East
    E = query(Grid, Y, X + 1),      %East
    SE = query(Grid, Y - 1, X + 1), %South East
    S = query(Grid, Y - 1, X),      %South
    SW = query(Grid, Y - 1, X - 1),  %South West
    W = query(Grid, Y, X - 1),      %West
    NW = query(Grid, Y + 1, X - 1), %North West
    NeighbourStates = [N, NE, E, SE, S, SW, W, NW],
    length(lists:filter(fun(State) -> State == alive end, NeighbourStates)).

game_logic(State, Neighbours) ->
    case State of 
        alive -> if
            Neighbours < 2 -> empty; % Die: to few 
            Neighbours > 3 -> empty; % Die: To many
            true -> State
        end;
        empty -> if
            Neighbours == 3 -> alive;
            true -> State
        end
    end.

step_cell(Grid, X, Y) ->
    State = query(Grid, Y, X),
    Neighbours = count_neighbours(Grid, Y, X),
    NextState = game_logic(State, Neighbours),
    #transition{state = NextState, y = Y, x = X}.

simulate(Grid) ->
    Rows = array:map(fun(Y, Row) ->
        array:map(fun(X, _CellValue) ->
            Transition = step_cell(Grid, Y, X),
            Transition#transition.state
        end, Row)
    end, Grid#grid.rows),
    Grid#grid{rows = Rows}.

print(Grid) ->
    ColumIndex = lists:seq(0, Grid#grid.width - 1),
    RowIndex = lists:seq(0, Grid#grid.height - 1),
    lists:foreach(fun(Y) ->
        io:format("|"),
        lists:foreach(fun(X) ->
            io:format(" ~s |", [draw(query(Grid, Y, X))]) end, ColumIndex),
        io:format("\n")
    end, RowIndex).

demo_grid() ->
    Grid = new(5, 9),
    Grid1 = assign(Grid, 0, 3, alive),
    Grid2 = assign(Grid1, 1, 4, alive),
    Grid3 = assign(Grid2, 2, 2, alive),
    Grid4 = assign(Grid3, 2, 3, alive),
    assign(Grid4, 2, 4, alive).

clear_screen() ->
    io:format("\ec").

run_simulation(Grid, N) ->
    clear_screen(),
    UpdatedGrid = simulate(Grid),
    print(UpdatedGrid),
    timer:sleep(1000),
    case N > 0 of
        true -> run_simulation(UpdatedGrid, N - 1);
        false -> end_simulation()
    end.

end_simulation() ->
    io:format("\nEnd of Simulation\n").