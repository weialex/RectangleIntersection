topo:-read(IN),proc(IN,NRet),find_int(NRet,NI,AI),clean_db(NRet),imprime(NI,AI).
topo:-print("erro na leitura").

%Armazena os retangulos dados pelo Input
%In: input
%NRet: numero de retangulos dados pelo Input
%Acc: acumular utilizado para a contagem de retangulos
proc(IN,NRet) :- proc(IN,NRet,0).
proc([],Acc,Acc).

proc([rect(N,X1,Y1,X2,Y2)|L],NRet,Acc) :-
	AccX is Acc+1,	
	asserta(rect(AccX,X1,Y1,X2,Y2)), 
	proc(L,NRet,AccX).

%Limpa o banco de dados salvo pelo programa, assim nao atrapalhando em uma 
%nova entrada
clean_db(0).
clean_db(NRet) :- retract(rect(NRet,A,B,C,D)), NRetX is NRet-1, clean_db(NRetX).

%Procura/Calcula interseccoes par a par de todos os retangulos (sem repeticao)
%NI/AccN: numero de interseccoes/acumulador de NI
%AI/AccA: valor da area de interseccao/acumulador de AI
%R1/R1X: numero do primeiro retangulo
%R2/R2X: numero do segundo retangulo
%Flag/FX: Indica se ja verificou todos os pares possiveis(1 Sim, 0 Nao)
find_int(NRet,NI,AI) :- find_int(NRet,NI,AI,1,2,0,0,0).
find_int(_,AccN,AccA,_,_,AccN,AccA,1).

find_int(NRet,NI,AI,R1,R2,AccN,AccA,Flag) :- 
	areaIntersect(R1,R2,A),
	AccAX is AccA+A,
	(A>0 -> AccNX is AccN+1; AccNX is AccN),	
	(R2 < NRet -> R2X is R2+1, R1X is R1; R1X is R1+1, R2X is R1+2),
	(R1X > NRet -> FX is 1; FX is 0),
	find_int(NRet,NI,AI,R1X,R2X,AccNX,AccAX,FX).

%Impressao da saida
imprime(NI,AI) :- 
	write("numero total de interseccoes: "), write(NI),
    nl, write("area total: "), write(AI), nl.

%areaIntersect(M,N,A)
%A: área da interseccao dos dois (se nao houver, será 0)
areaIntersect(R1,R2,A) :- 
	xEsq(R1,R2,X1,F1), ySup(R1,R2,Y1,F2), xDir(R1,R2,X2), yInf(R1,R2,Y2),!,
	((F1<0 ; F2<0) -> A is 0; calcArea(X1,Y1,X2,Y2,A)).
areaIntersect(_,_,A) :- A is 0.

%calcArea(X1,Y1,X2,Y2,A)
%X1: coordenada x do lado esquerdo do retangulo
%Y1: coordenada y do lado superior do retangulo
%X2: coordenada x do lado direito do triangulo
%Y2: coordenada y do lado inferior do retangulo
calcArea(X1,Y1,X2,Y2,A) :- L is X2-X1, H is Y1-Y2, A is H*L.

%Obtem o valor do x1 do retangulo formado pela interseccao de M e N.
%xEsq(M,N,R,F)
%R: valor para o x1 do retangulo de interseccao
%F: flag que indica se houve interseccao
xEsq(R1,R2,R,F) :- 
	rect(R1,X1,_,_,_),rect(R2,A1,_,A2,_), X1<A2, X1>A1, R is X1, F is 1.
xEsq(R1,R2,R,F) :- 
	rect(R1,X1,_,X2,_),rect(R2,A1,_,_,_), A1<X2, A1>X1, R is A1, F is 1.
xEsq(_,_,R,F) :- R is 0, F is 0. %Nao ocorre interseccao.

%Obtem o valor do y1 do retangulo formado pela interseccao de M e N.
%ySup(M,N,R,F)
%R: valor para o y1 do retangulo de interseccao
%F: flag que indica se houve interseccao
ySup(R1,R2,R,F) :- 
	rect(R1,_,Y1,_,_),rect(R2,_,B1,_,B2), Y1<B1, Y1>B2, R is Y1, F is 1.
ySup(R1,R2,R,F) :- 
	rect(R1,_,Y1,_,Y2),rect(R2,_,B1,_,_), B1<Y1, B1>Y2, R is B1, F is 1.
ySup(_,_,R,F) :- R is 0, F is 0. %Nao ocorre interseccao.

%Obtem o valor do x2 do retangulo formado pela interseccao de M e N.
%xDir(M,N,R,F)
%R: valor para o x2 do retangulo de interseccao
%*A Flag F nao eh necessária aqui, pois as verificacoes 
% por xEsq e ySup ja sao suficientes.
xDir(R1,R2,R) :- rect(R1,_,_,X2,_),rect(R2,A1,_,A2,_), X2<A2, X2>A1, R is X2.
xDir(R1,R2,R) :- rect(R1,X1,_,X2,_),rect(R2,_,_,A2,_), A2<X2, A2>X1, R is A2.

%Obtem o valor do y2 do retangulo formado pela interseccao de M e N.
%ySup(M,N,R,F)
%R: valor para o y2 do retangulo de interseccao
%*A flag F nao é necessária aqui, pois as verficacões 
% por xEsqu e ySup já sao suficientes.
yInf(R1,R2,R) :- rect(R1,_,_,_,Y2),rect(R2,_,B1,_,B2), Y2<B1, Y2>B2, R is Y2.
yInf(R1,R2,R) :- rect(R1,_,Y1,_,Y2),rect(R2,_,_,_,B2), B2<Y1, B2>Y2, R is B2.
