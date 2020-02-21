%%%%%%%%%%%%%%%OGUZHAN SENTÜRK%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%osenturk@gtu.edu.tr%%%%%%%%%%%%

% KNOWLEDGE BASE

flight(edirne,edremit).
flight(edremit,erzincan).
flight(edremit,edirne).
flight(erzincan,edremit).

flight(istanbul,izmir).
flight(izmir,isparta).
flight(isparta,burdur).
flight(izmir,istanbul).
flight(isparta,izmir).
flight(burdur,isparta).

flight(istanbul,rize).
flight(rize,van).
flight(van,ankara).
flight(ankara,konya).
flight(konya,antalya).
flight(antalya,gaziantep).
flight(istanbul,gaziantep).
flight(istanbul,antalya).
flight(istanbul,ankara).
flight(istanbul,van).

flight(rize,istanbul).
flight(van,rize).
flight(ankara,van).
flight(konya,ankara).
flight(antalya,konya).
flight(gaziantep,antalya).
flight(gaziantep,istanbul).
flight(antalya,istanbul).
flight(ankara,istanbul).
flight(van,istanbul).

distance(edirne,edremit,252).
distance(edremit,erzincan,993).
distance(edremit,edirne,252).
distance(erzincan,edremit,993).

distance(istanbul,izmir,329).
distance(izmir,isparta,309).
distance(isparta,burdur,25).
distance(izmir,istanbul,329).
distance(isparta,izmir,309).
distance(burdur,isparta,25).

distance(istanbul,rize,968).
distance(rize,van,373).
distance(van,ankara,920).
distance(ankara,konya,227).
distance(konya,antalya,192).
distance(antalya,gaziantep,592).
distance(istanbul,gaziantep,847).
distance(istanbul,antalya,483).
distance(istanbul,ankara,352).
distance(istanbul,van,1262).

distance(rize,istanbul,968).
distance(van,rize,373).
distance(ankara,van,920).
distance(konya,ankara,227).
distance(antalya,konya,192).
distance(gaziantep,antalya,592).
distance(gaziantep,istanbul,847).
distance(antalya,istanbul,483).
distance(ankara,istanbul,352).
distance(van,istanbul,1262).

%rule
%route predicate invoke findroute function
%Path to see path without path program so confused, and dont know program work exactly corret
route(X,Y) :- findRoute(X,Y,Path,[]), write("Route: "),write(Path),nl.

%recursively finding the routes
%X is starting point
%Y is destination point
%visited point append visited list because prevent infinite loop
findRoute(X, Y,[X,Y], T) :-flight(X, Y),\+ member(Y,T).

findRoute(X, Y, [X|P], T) :-
	flight(X, Z),
	\+ member(Z, T),
	append([X],T,Visited),
	findRoute(Z, Y, P, Visited).

%same algorithm route predicate but this situation i add path distance and find shortest path between two point
%W is distance
droute(X,Y,W) :-
	findshort(X,Y,W,Path,[]),
	write("Route: "),
	write(Path),nl,
	write("Distance= "),
	write(W),nl.

findshort(X, Y, W, [X,Y], T) :- distance(X, Y, W), \+ member(Y,T).

findshort(X, Y, W, [X|P], T) :-
	distance(X, Z, W1),
	\+ member(Z, T),
	append([X],T,Visited),
	findshort(Z, Y, W2, P, Visited),
	W is W1 + W2.

%setof use find shortest path
sroute(X, Y, Z) :- setof(C, droute(X, Y, C), [Z|_]).
