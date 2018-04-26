%rect(N,x1,y1,x2,y2)
%N: número do retângulo
%x1: coordenada x do lado esquerdo (menor x)
%y1: coordenada y do lado superior (maior y)
%x2: coordenada x do lado direito (maior x)
%y2: coordenada y do lado inferiro (menor y)
rect(1,1,2,3,0).
rect(2,2,3,5,1).
rect(3,6,6,9,9).
rect(a,0,6,3,4).
rect(b,1,5,2,3).
rect(c,1,2,4,1).
rect(d,3,3,5,0).
rect(e,4,6,5,4).
rect(f,3.5,6.5,6,3.5).
rect(-1,0,0,0,0).

%areaIntersect(M,N,A)
%M: número do primeiro retângulo
%N: número do segundo retângulo
%A: área da intersecção dos dois (se não houver, será 0)
areaIntersect(M,N,A) :- xEsq(M,N,X1,F1), !, F1>0, ySup(M,N,Y1,F2), !, F2>0, xDir(M,N,X2), !, yInf(M,N,Y2), !, calcArea(X1,Y1,X2,Y2,A).
areaIntersect(_,_,A) :- A is 0.

%calcArea(X1,Y1,X2,Y2,A)
%X1: coordenada x do lado esquerdo do retângulo
%Y1: coordenada y do lado superior do retângulo
%X2: coordenada x do lado direito do triângulo
%Y2: coordenada y do lado inferior do retângulo
calcArea(X1,Y1,X2,Y2,A) :- L is X2-X1, H is Y1-Y2, A is H*L.

%Este predicado obtém o valor do x1 do retângulo formado pela intersecção de M e N.
%xEsq(M,N,R,F)
%M: número do primeiro retângulo
%N: número do segundo retângulo
%R: valor para o x1 do retângulo de intersecção
%F: flag que indica se houve intersecção
xEsq(M,N,R,F) :- rect(M,X1,_,_,_),rect(N,A1,_,A2,_), X1<A2, X1>A1, R is X1, F is 1.
xEsq(M,N,R,F) :- rect(M,X1,_,X2,_),rect(N,A1,_,_,_), A1<X2, A1>X1, R is A1, F is 1.
xEsq(_,_,R,F) :- R is 0, F is 0. %Não ocorre intersecção.

%Esta predicado obtém o valor do y1 do retângulo formado pela intersecção de M e N.
%ySup(M,N,R,F)
%M: número do primeiro retângulo
%N: número do segundo retângulo
%R: valor para o y1 do retângulo de intersecção
%F: flag que indica se houve intersecção
ySup(M,N,R,F) :- rect(M,_,Y1,_,_),rect(N,_,B1,_,B2), Y1<B1, Y1>B2, R is Y1, F is 1.
ySup(M,N,R,F) :- rect(M,_,Y1,_,Y2),rect(N,_,B1,_,_), B1<Y1, B1>Y2, R is B1, F is 1.
ySup(_,_,R,F) :- R is 0, F is 0. %Não ocorre intersecção.

%Esta predicado obtém o valor do x2 do retângulo formado pela intersecção de M e N.
%xDir(M,N,R,F)
%M: número do primeiro retângulo
%N: número do segundo retângulo
%R: valor para o x2 do retângulo de intersecção
%*A Flag F não é necessária aqui, pois as verificações por xEsq e ySup já são suficientes.
xDir(M,N,R) :- rect(M,_,_,X2,_),rect(N,A1,_,A2,_), X2<A2, X2>A1, R is X2.
xDir(M,N,R) :- rect(M,X1,_,X2,_),rect(N,_,_,A2,_), A2<X2, A2>X1, R is A2.

%Esta predicado obtém o valor do y2 do retângulo formado pela intersecção de M e N.
%ySup(M,N,R,F)
%M: número do primeiro retângulo
%N: número do segundo retângulo
%R: valor para o y2 do retângulo de intersecção
%*A flag F não é necessária aqui, pois as verficações por xEsqu e ySup já são suficientes.
yInf(M,N,R) :- rect(M,_,_,_,Y2),rect(N,_,B1,_,B2), Y2<B1, Y2>B2, R is Y2.
yInf(M,N,R) :- rect(M,_,Y1,_,Y2),rect(N,_,_,_,B2), B2<Y1, B2>Y2, R is B2.
