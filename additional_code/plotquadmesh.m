function plotquadmesh(vertex,face)
%usefull for the mesh subdivision project
%figure, 
set(gcf,'Color','w');
set(gcf,'Renderer','OpenGL')
face_color=.6;
edge_color=.8;
patch('vertices',vertex,'faces',face,'facecolor',[face_color face_color face_color],...
        'edgecolor',[edge_color edge_color edge_color])
axis equal;

axis off

%rzview('on')

% lims=real(boundbox(vertex,face));
% %lipos=[lims(1)+lims(2) lims(3)+lims(4) lims(5)+lims(6)]/2;
 lighting phong;
% %set(h1,'edgelighting','phong');
% hc=camlight('local');
% set(hc,'color','b');
% 
% %light('Position',[2 1 15],'Style','infinite','color','y');
% light('Position',[lims(2) lims(4) 0],'Style','local','color',[ 0.000 0.000 0.627 ]);
% %light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
% light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.000 0.502 1.000 ]);
% light('Position',[lims(2) 0 lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
% light('Position',[0 lims(3) lims(5)-lims(6)-2],'Style','local','color',[ 0.906 0.306 0.012 ]); 