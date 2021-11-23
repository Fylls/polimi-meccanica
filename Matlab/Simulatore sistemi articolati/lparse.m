function ss=lparse(s,delim,n)

if nargin<3,
    n=1;
end
dN=length(delim);
N=length(s);
k=strfind(s,delim);
kN=size(k,2);
if n>kN,
    ss='';
else
    ss=s(1:k(n)-dN);
end
