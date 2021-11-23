function ss=rparse(s,delim,n)
ss='';
if nargin<3,
    n=1;
end
N=size(s,2);
dN=size(delim,2);
k=strfind(s,delim);
kN=size(k,2);
if n>kN,
    n=kN;
end
if ~isempty(k)
ss=s(k(n)+dN:N);
end

