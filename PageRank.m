function [R R1] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out 
  
  % deschis fisierul dat ca si parametru
  fid = fopen(nume, 'r');
  
  % citesc N, adica nr de pag web analizate
  N = fscanf(fid, "%d",1);
  
  % citesc din fisier val1 si val2 din formula lui u
  while (!feof(fid))
    val0 = fscanf(fid, "%f", 1);
    val1 = fscanf(fid, "%f", 1);
    val2 = fscanf(fid, "%f", 1);
  endwhile
  fclose(fid);
  
  % creez numele noului fisier
  nume_2 = [nume ".out"];
  
  % deschid fisierul creat si scriu in fisier ceea ce mi s-a cerut
  fid_2 = fopen(nume_2, 'w');
  fprintf(fid_2, "%d\n", N);
  fprintf(fid_2, "\n");
  
  % scriu in fisierul nou outputul fct de la cerinta 1
  [R] = Iterative(nume, d, eps);
  fprintf(fid_2, "%.6f\n", R(1:N));
  fprintf(fid_2, "\n");
  
  % scriu in fisierul nou outputul fct de la cerinta 2
  [R] = Algebraic(nume, d);
  fprintf(fid_2, "%.6f\n", R(1:N));
  fprintf(fid_2, "\n");
  
  % salvez intr-un nou vector coloana valorile vectorului R sortate descrescator
  R1 = sort(R, 'descend');
  
  % pentru fiecare numar din vectorul R1 afisez pozitia elementului in R,
  % pozitia elementului in R1 si valoarea fct u descrisa in cerinta pentru 
  % elementul respectiv 
  for i =1:N
    fprintf(fid_2, "%d ", i);
    for j =1:N
      if R1(i) == R(j)
        aux = j; % poz elementului in vect nesortat
      endif
    endfor
    fprintf(fid_2, "%d ", aux);
    [u] = Apartenenta(R1(i), val1, val2);
    fprintf(fid_2, "%.6f\n", u);
  endfor
  fclose(fid_2);
endfunction