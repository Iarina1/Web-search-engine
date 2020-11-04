function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
  
  %deschid fisierul
	fid = fopen(nume, 'r');
  
  % citesc din fisier nr N, adica nr de pag web analizate
  N = fscanf(fid, "%d",1);
  nr_lin = N;
  A = zeros(N);
  dim = [];
  
  % citesc urmatoarele N linii si le salvez pe rand in vect; nr de pe pozitia
  % 3 din vect pana la final reprezinta vecinii nr de pe pozitia 1 din vect
  while N ~= -1
    string_vect =  fgetl(fid);
    vect = str2num(string_vect);
    if length(vect) ~= 0
      A(vect(1),vect(3:end)) = 1; % creez matricea de adiacenta
    endif
    N -= 1;
  endwhile
  %inchid fisierul
  fclose(fid);
  D_A = diag(diag(A));
  A = A - D_A; % ma asigur ca A are pe diag principala numai 0
  N = nr_lin;
  
  % pentru fiecare linie din fisier calculez nr de 1
  % si il salvez in vectorul dim
  for i=1:N
    L = 0;
    for j=1:N
      if A(i,j) == 1
        L += 1;
      endif
    endfor
    dim(i) = L;
  endfor
  
  % calculez matricea M din cerinta
  for i=1:N
    for j=1:N
      if A(j,i) == 1
        M(i,j) = 1/dim(j);
      else
        M(i,j) = 0;
      endif
    endfor
  endfor
  
  vect_1 = ones(N,1);
  K = eye(N);
  K = K - d*M;
  R = PR_Inv(K)*(1-d)/N*vect_1;
endfunction