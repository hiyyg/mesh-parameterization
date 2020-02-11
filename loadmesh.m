function [Vertex, Face] = loadmesh(filename)
%LOADMESH read an OFF file and returns 
%Vertex is a 3xnbr vertices  matrix
%Face is 3xnbr triangles matrix or 4xnbr Quads

%r.zayer 17.2.2004
% 


% Read in new nodes.

fid = fopen(filename, 'r');
%simple file check
if fid==-1
    error('File not found or permission denied');
    return
end
%simple format check
formatz=fscanf(fid, '%s', 1);
if ~strcmp(formatz,'OFF')
    error('Not an OFF File Format. Check file format and try again!');
    return
end        
%
nvnt = fscanf(fid, '%d %d %d', 3);
nV=nvnt(1,1);
nT=nvnt(2,1);

% Read vertices
fprintf('...Reading %d Vertices\n',nV);
Vertex = fscanf(fid,'%f',[3,nV]);

% Read faces
fprintf('...Reading %d Faces\n',nT);

ft=fscanf(fid,'%d',1);
fseek(fid,-1,'cof');
if ft==3
    Face = fscanf(fid,'%d',[4,nT]);
    % remove first row (all 3), translate and
    % add 1 because OFF triangles start at zero
    Face = Face(2:4,:) + 1;
elseif ft==4
    Face = fscanf(fid,'%d',[5,nT]);
    % remove first row (all 3), translate and
    % add 1 because OFF triangles start at zero
    Face = Face(2:5,:) + 1;
end
fclose(fid);

