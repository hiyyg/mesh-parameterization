function [h2]=plotflatmesh(vertex,face,vnormals,options)

%
%   'options' is a structure that may contains:
%       - 'edge_color' :  float specifying the color of the edges.
%       - 'face_color' :  float specifying the color of the faces.
%       - 'face_vertex_color' : color per vertex or face.


if nargin<2
    error('Not enough arguments.');
end
if nargin<4
    options.null = 0;
end



if ~isfield(options, 'face_color')
    options.face_color = 0.6;
end
face_color = options.face_color;

if ~isfield(options, 'edge_color')
    options.edge_color = 0.4;
end
edge_color = options.edge_color;

if ~isfield(options, 'face_vertex_color')
    options.face_vertex_color = [];
end
face_vertex_color = options.face_vertex_color;

%set background to white
set(gcf,'Color','w');


if isempty(face_vertex_color)
    h2=patch('vertices',vertex,'faces',face,'facecolor',[face_color face_color face_color],...
        'edgecolor',[edge_color edge_color edge_color],'edgealpha',0.3,'linestyle','-'); 
else
    nverts = size(vertex,1);
    % vertex_color = rand(nverts,1);
    if size(face_vertex_color,1)==size(vertex,1)
        shading_type = 'interp';
    else
        shading_type = 'flat';
    end
    h2=patch('vertices',vertex,'faces',face,'FaceVertexCData',face_vertex_color,...
        'FaceColor',shading_type,'linestyle','-');
end
%
axis equal; 
axis off;
%
%camproj('perspective');
camproj('orthographic');
camlight headlight 
%
%light('Position',[1 1 5],'Style','infinite','color','y');
%light('Position',[0.43 0.5 0.75],'Style','infinite','color','w');
set(h2,'edgelighting','phong');
camlight infinite; lighting phong;
%
set(gcf,'Renderer','OpenGL')

if not(isempty(vnormals))
    set(h2, 'VertexNormals', vnormals)
end

lims=real(boundbox(vertex,face));
lipos=[lims(1)+lims(2) lims(3)+lims(4) lims(5)+lims(6)]/2;
lighting phong;
%set(h2,'edgelighting','phong');
hc=camlight('local');
set(hc,'color','b');

%light('Position',[2 1 15],'Style','infinite','color','y');
light('Position',[lims(2) lims(4) 0],'Style','local','color',[ 0.000 0.000 0.627 ]);
%light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
light('Position',[0 lims(4) lims(6)],'Style','local','color',[ 0.000 0.502 1.000 ]);
light('Position',[lims(2) 0 lims(6)],'Style','local','color',[ 0.855 0.804 0.996 ]);
light('Position',[0 lims(3) lims(5)-lims(6)-2],'Style','local','color',[ 0.906 0.306 0.012 ]); 
%camproj('perspective');( picking works only with ortho
%light('Position',[2 1 15],'Style','infinite','color','y');





%campos([-6,-6,-1]);
% %%%added
% view(3);
% cam_pos=get(gca,'CameraPosition');
% tar_pos=get(gca,'CameraTarget');
% cam_pos=0.3.*(cam_pos-tar_pos)+tar_pos;
% set(gca,'CameraPosition',cam_pos);
% %%%%end added

%vnormals=get(h2,'VertexNormals');
rzview('on');

