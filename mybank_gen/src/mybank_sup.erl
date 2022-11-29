-module(mybank_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Children = [
        {
            mybank_atm,
            {mybank_atm, start_link, []},
            permanent,
            10000,
            worker,
            [mybank_atm]
        }
    ],
    {ok, {{one_for_one, 10, 10}, Children}}.
   