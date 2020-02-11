function [boundaryloops,rbl]=getbloops(p,t, debug)
%% get the boundary loops of a given input mesh

nv=size(p,2);

A=sparse(t([1 2 3],:),t([2 3 1],:),1,nv,nv);

% The neighbors of any given vertex vi can be obtained
% from the connectivity matrix C as
%find neighbors
%nvi= find(C(i,:));
% A simple way to check if the mesh has a boundary would
% be to compute the matrix B
B=A-A';
Bplus=spones(B==1);
%Bminus=spones(B==-1);


[ri,rj]=find(Bplus);%find returns row and col indices
%[rl,rk]=find(Bminus); 


bndry=rj;
%rbndry=rl;
%lbndry=ri;
%rbl=[rl rj ri];


boundaryloops=[];
%if bndry
%boundary=cell(1,size(bndry,2));
ib=1;
tic
while bndry
    %bbegin=1;
    [~,bloop]=predecessor(Bplus,bndry(1));
    bndry=setdiff(bndry,bloop);
    
    boundaryloops{1,ib}=bloop';
    ib=ib+1;
end

took=toc;       
        

%% vis

if ~iscell(boundaryloops)
    warning('the current mesh has no boundary!')
else
    disp('boundaries are detected for current mesh')
    if debug
        figure; plotmesh(p',t'); hold on
        for i=1:length(boundaryloops)
            ie=[boundaryloops{i}];
            ie=[ie ie(1)];
            klr=rand(1,3);
            line(p(1,ie),p(2,ie),p(3,ie),'Color',klr,...
                'linewidth',3,'linesmoothing','on');
        end
    end
end
%%

        
        
        
        
        
        
        
        
        

