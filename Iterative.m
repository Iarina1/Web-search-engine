function [R] = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

 fid = fopen(nume, 'r');
  N = fscanf(fid, "%d",1);
  nr_lin = N;
  A = zeros(N);
  dim = [];
  while N ~= -1
    string_vect =  fgetl(fid);
    vect = str2num(string_vect);
    if length(vect) ~= 0
      A(vect(1),vect(3:end)) = 1;
      dim = [dim; length(vect)];
    endif
    N -= 1;
  endwhile
  fclose(fid);
  D_A = diag(diag(A));
  A = A - D_A;
  N = nr_lin;
  for i=1:N
    L = 0;
    for j=1:N
      if A(i,j) == 1
        L += 1;
      endif
    endfor
    dim(i) = L;
  endfor
  for i=1:N
    for j=1:N
      if A(j,i) == 1
        M(i,j) = 1/dim(j);
      else
        M(i,j) = 0;
      endif
    endfor
  endfor
% pasii de mai sus au fost explicati in fct "Algebraic"
 N = nr_lin;
 R = zeros(N,1);
 R(1:end) = 1/N;
 prev_R = R;
 vect_1 = ones(N,1);
 while 1
   R = d*M*prev_R + (1-d)/N*vect_1;
   if norm(R-prev_R) < eps
     R = prev_R; % returnez cu valoarea lui R de la iteratia anterioara
     return;
   endif
   prev_R = R;
 endwhile
endfunction