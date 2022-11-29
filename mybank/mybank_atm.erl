-module(mybank_atm).
-export([start_link/0]).
-export([stop/0]).
-export([deposit/2]).
-export([balance/1]).
-export([init/0]).
-export([get_current_balace/2]).
-export([withdraw/2]).

-record(state, {
    accounts
}).

%% ============ API ============
start_link() ->
    io:format("-----> Opening Bank. \n"),
    Pid = spawn_link(?MODULE, init, []),
    register(?MODULE, Pid),
    {ok, Pid}.
stop() ->
    ?MODULE ! terminate.

deposit(AccountId, Amount) ->
    ?MODULE ! {deposit, self(), AccountId, Amount},
    receive
        Reply -> Reply
    after 5000 ->
        {error, timeout}
    end.

balance(AccountId) ->
    ?MODULE ! {balance, self(), AccountId},
    receive
        Reply -> Reply
    after 5000 ->
        {error, timeout}
    end.
withdraw(AccountId, Amount) ->
    ?MODULE ! {withdraw, self(), AccountId, Amount},
    receive
        Reply -> Reply
    after 5000 ->
        {error, timeout}
    end.
%% ============ INTERNAL ============
init() ->
    Accounts = dict:new(),
    State = #state{accounts = Accounts},
    main_loop(State).

main_loop(#state{accounts = Accounts} = State) ->
    receive
        {deposit, CallerPid, AccountId, Amount} ->
            CurrentBalance = get_current_balace(AccountId, Accounts),
            Accounts1 = dict:store(
                AccountId, 
                CurrentBalance+Amount, 
                Accounts),
            CallerPid ! ok,
            main_loop(State#state{accounts = Accounts1});
        {balance, CallerPid, AccountId} ->
            CallerPid ! {ok, get_current_balace(AccountId, Accounts)},
            main_loop(State);
        {withdraw, CallerPid, AccountId, Amount} ->
            case get_current_balace(AccountId, Accounts) of
                CurrentBalance when Amount =< CurrentBalance ->
                    Accounts1 = dict:store(
                        AccountId,
                        CurrentBalance - Amount,
                        Accounts
                    ),
                    CallerPid ! ok,
                    main_loop(State#state{accounts = Accounts1});
                _ ->
                    CallerPid ! {error, not_enough_balance},
                    main_loop(State)
            end;
        terminate ->
            io:format("-----> Closing Bank. \n")
    end.

get_current_balace(AccountId, Accounts) ->
    case dict:find(AccountId, Accounts) of
        error -> 0;
        {ok, Amount0} -> Amount0
    end.