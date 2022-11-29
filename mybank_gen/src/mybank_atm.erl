-module(mybank_atm).
-behaviour(gen_server).

-export([start_link/0, stop/0]).
-export([deposit/2]).
-export([balance/1]).
-export([get_current_balace/2]).
-export([withdraw/2]).

%% Gen Server Callbacks
-export([handle_call/3, handle_cast/2, handle_info/2]).
-export([init/1, terminate/2,code_change/3]).

-record(state, {
    accounts
}).

%% ============ API ============
start_link() ->
    io:format("-----> Opening Bank. \n"),
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop() ->
    gen_server:stop(?MODULE).

deposit(AccountId, Amount) ->
    gen_server:call(?MODULE, {deposit, AccountId, Amount}).

balance(AccountId) ->
    gen_server:call(?MODULE, {balance, AccountId}).
withdraw(AccountId, Amount) ->
    gen_server:call(?MODULE, {withdraw, AccountId, Amount}).


%% ============ INTERNAL ============
init([]) ->
    Accounts = dict:new(),
    State = #state{accounts = Accounts},
    {ok, State}.

handle_call({deposit, AccountId, Amount}, _From, #state{accounts = Accounts} = State) ->
    CurrentBalance = get_current_balace(AccountId, Accounts),
    Accounts1 = dict:store(
        AccountId, 
        CurrentBalance + Amount, 
        Accounts),
    {reply, ok, State#state{accounts = Accounts1}};

handle_call({balance, AccountId}, _From, #state {accounts = Accounts} = State) ->
    CurrentBalance = get_current_balace(AccountId, Accounts),
    {reply, CurrentBalance, State};

handle_call({withdraw, AccountId, Amount}, _From, #state{accounts = Accounts} = State) ->
    case get_current_balace(AccountId, Accounts) of
        CurrentBalance when Amount =< CurrentBalance ->
            Accounts1 = dict:store(
                AccountId,
                CurrentBalance - Amount,
                Accounts
            ),
            {reply, ok, State#state{accounts = Accounts1}};
        _ ->
            {reply, {error, not_enough_balance}, State}
    end;

handle_call(_Msg, _From, State) ->
    {reply, undefined, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.
handle_info(_Info, State) ->
    {noreply, State}.
terminate(_Reason, _State) ->
    io:format("-----> Closing Bank"),
    terminated.
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

get_current_balace(AccountId, Accounts) ->
    case dict:find(AccountId, Accounts) of
        error -> 0;
        {ok, Amount0} -> Amount0
    end.