function [x,stack]=predecessor(G,v)
x=sparse(length(G),1);
xold=x;
x(v)=1;%start BFS from v
stack=v;

while any(x~=xold)
    
    xold=x;
    
    x=x|G*x;
    
    
    %x=(G+speye(size(G)))*x;
        
    %     stack=[stack find(x &~xold)];
    %xor(x,xold);
    stack=[stack; find(xor(x,xold))];
    %disp('------')    
    
end
