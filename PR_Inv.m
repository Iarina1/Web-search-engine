function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Se va inlocui aceasta linie cu descrierea algoritmului de inversare 
  [m n] = size(A);
  Q = zeros(m, n);
  R = zeros(n);
    
  for i = 1:n
    R(i,i) = norm(A(:,i),2);
    Q(:,i) = A(:,i)/R(i,i);    
      for j = i+1:n
        R(i,j) = Q(:,i)'*A(:,j);
        A(:,j) = A(:,j) - Q(:,i)*R(i,j);
      endfor
  endfor
  N = size(A);
  B = [];
  Q = Q';
  for i=1:N
    x = SST(R,Q(:,i));
    B = [B, x];
  endfor
endfunction