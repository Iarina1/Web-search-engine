function [x] = SST(A, b)
n=length(b);
x=[];
x = [b(n)/A(n,n); x];
for i=n-1:-1:1
    x=[(b(i)-A(i,i+1:n)*x)/A(i,i);x];
endfor
endfunction