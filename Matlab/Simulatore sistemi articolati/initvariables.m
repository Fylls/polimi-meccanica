function [symb,X]=initvariables(varargin)
for i=1:nargin/2,
    symb{i}=varargin{2*i-1};
    X(i)=varargin{2*i};
end
symb=symb';
X=X';
