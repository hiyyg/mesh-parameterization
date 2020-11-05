clear, close all;


[p,t]=loadmesh('samplemeshes/mushroom.off');%mac

%[p,t]=loadmesh('samplemeshes\mushroom.off');%windows


p=p'; %flip to colums for convenience in matrix multiplication

figure, plotmesh(p,t');
rzview('on') %allows for rotating zoom and move with the mouse (left-right-middle)