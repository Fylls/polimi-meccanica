function [v]=subsymbols(v,symb,item)
N=length(symb);

%replace all symbolic variables
for i=1:N
    k=strfind(v,symb{i});
    if ~isempty(k)
        v=replace(v,symb{i},['X(' num2str(i) ')']);        
    end
end
 

%search and replace all item references:
if ~isstruct(item)
    return
end
ff=fields(item);

Nf=length(ff);

for j=1:Nf
   v=replace(v,ff{j},['item.' ff{j}]);
end
