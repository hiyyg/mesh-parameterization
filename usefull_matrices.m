% The matrices presented here, emphasize the relation
% between classical mesh traversal data structures and the
% sparse matrix representation.
% Let M be a mesh having nv vertices and nt Triangles.
% The vertex coordinates are stored in a 3*nv array v
% and the triangles are stored as 3*nt array t. in the rest
% of the paper we assume the input mesh triangles are
% consistently oriented counterclockwise (CCW).
% The connectivity matrix C can be constructed as

%returns connectivity matrix of a triangulation t
C=sparse(t([1 2 3],:),t([2 3 1],:),1,nv,nv);

% The neighbors of any given vertex vi can be obtained
% from the connectivity matrix C as
%find neighbors
nvi= find(C(i,:));
% A simple way to check if the mesh has a boundary would
% be to compute the matrix B
B=A-A';
% If B is a null matrix then the mesh has no boundary.
% When B is not null then entries with value 1 indicate
% edges in ccw( row and col indices) and -1 entries gives
% entries that are clockwise oriented.
[ri,rj]=find(B==1);%find returns row and col indices
[rl,rk]=find(B==-1);

% By inspecting left and right exterior neighbors of boundary
% vertices, it is a straightforward exercise to get the
% boundary loops.

% The full edges of a mesh could be obtained from the
% connectivity matrix C by using the function triu which
% returns the upper triangular part of a matrix.

[i j] = find(triu(c+c'));

% While the connectivity matrix encodes directed edge
% connectivity, it is possible to use a similar structure for
% pointing or to the next or previous vertex e.g.

C=sparse(t([1 2 3],:),t([2 3 1],:),t([3 1 2],:),nv,nv);

%or for encoding the triangles adjacent to edges

C=sparse(t([1 2 3],:),t([2 3 1],:),[1:nt; 1:nt; 1:nt],nv,nv);

% Often it is required to find a triangle fan around a vertex.
% In the sparse matrix framework this reads as simple as

VT=sparse(t([1 2 3],:),[1:nt; 1:nt; 1:nt], ones(1,3*nt),np,nt);
%fan of vertex i
fani=VT(:,i);