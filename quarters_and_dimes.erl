-module(quarters_and_dimes).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

process_a_list([A|[B|List]]) ->
    process(A,B,A,B,List,[]).

process(OriginalA,OriginalB,A,B,[],NewList) ->
    [avg(B,OriginalB) |lists:reverse([avg(A,OriginalA) | NewList])];
process(OriginalA,OriginalB,A,B,[C|List],NewList) ->
    NewB = avg(A,C),
    process(OriginalA,OriginalB,B,C,List,[NewB|NewList]).

avg(A,B) when B < A ->
    avg(A,B+360.0);
avg(A,B) ->
    drop_360( (A + B) / 2.0).

drop_360(X) when X >= 360.0 ->
    drop_360(X - 360.0);
drop_360(X) ->
    X.

-ifdef(EUNIT).

simple_test() ->
    ?assertEqual([0.0,90.0,180.0,270.0],process_a_list([0.0,90.0,180.0,270.0])).

shift_test() ->
    ?assertEqual([0.0,90.0,100.0,270.0],process_a_list([0.0,90.0,100.0,270.0])).
							    
-endif.
