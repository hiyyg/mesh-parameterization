clear, close all;

% Sample meshes to test - sphere, balls_param, eightparam, female2WB25param
[p,t]=loadmesh('samplemeshes/hand.off'); %mac visualize mesh as we begin
n_vertices = size(p,2);

figure;
fig1 = plotmesh(p',t');
%vnormals = [];
vnormals=get(fig1,'VertexNormals');
%waitfor(h1);

%rzview('on') %allows for rotating zoom and move with the mouse (left-right-middle)

debug_bloop =    true;
p_bound_idx = getbloops(p, t, debug_bloop); %fetch indices of boundary vertices

if isempty(p_bound_idx)
    return;
end

p_bound_idx = p_bound_idx{1,1} % first element in the cell contains these indices
p_bound_idx_s = circshift(p_bound_idx,1); %shift the boundary indices by 1 position 
p_bound_edges = p(:,p_bound_idx) - p(:,p_bound_idx_s) %matrix containing bounday edges as columns
%bound_len = vecnorm(p_bound_edges); %Get euclidean distance between adjacent vertices, need at least matlab 2017(b)

n_p_bound = size(p_bound_idx,2) % Get the number of boundary points
pariwise_b_len = zeros(1, n_p_bound);

for i=1:n_p_bound
    pairwise_b_len(:,i) = norm(p_bound_edges(:,i)); % Get euclidean distance between adjacent vertices
end
pairwise_b_len
b_len = sum(pairwise_b_len) % Length of the boundary loop

% We map boundaries to a square/quadrilateral in 2D
sqr_edge_expected_len = b_len / 4; %Edge length of the square 
sqr_edge_actual_len = 0; 

u_bound = zeros(2, n_p_bound); %uv coordinates of the boundary points
%u_bound(:,1) = [-sqr_edge_expected_len/2 -sqr_edge_expected_len/2]; % Intialize the first point to (0, 0)- not required
for i=2:n_p_bound
    sqr_edge_actual_len = sqr_edge_actual_len + pairwise_b_len(:,i-1);
    if sqr_edge_actual_len <= sqr_edge_expected_len
        u_bound(:, i) = [u_bound(1, i-1) + pairwise_b_len(:,i-1) u_bound(2, i-1)];
    elseif sqr_edge_actual_len <= 2 * sqr_edge_expected_len
        u_bound(:, i) = [u_bound(1, i-1)  u_bound(2, i-1) + pairwise_b_len(:,i-1)];
    elseif sqr_edge_actual_len <= 3 * sqr_edge_expected_len
        u_bound(:, i) = [u_bound(1, i-1) - pairwise_b_len(:,i-1) u_bound(2, i-1)];
    else
        u_bound(:, i) = [u_bound(1, i-1) u_bound(2, i-1) - pairwise_b_len(:,i-1)];
    end
end
u_bound
%p = p(1:2, :)
%plotflatmesh(p', t')

m = Laplacian_matrix(p, t); %Compute the weights (cot)  

% Verify that row sum is zero
%for i=1:n_vertices
 %   sum(m(i,:))
%end

%Modify weights such that for row corresponding to boundary index, diagonal
%entry should be 1, all others zeros - hences boundary vertices are mapped
%exactly
%full(m);
m(p_bound_idx, :) = 0;
for i = p_bound_idx
    m(i, i) = 1;
end
%full(m);

% Compute u coordinates
%c_u = sparse(p_bound_idx, 1, u_bound(1,:), n_vertices, 1); %create sparse vector for the right hand side of the system 
%c_v = sparse(p_bound_idx, 1, u_bound(2,:), n_vertices, 1);% create sparse vector for the right hand side of the system 
c_u = zeros(n_vertices, 1);
c_v = zeros(n_vertices, 1);
c_u(p_bound_idx) = u_bound(1,:);
c_v(p_bound_idx) = u_bound(2,:);

u = m \ c_u;
v = m \ c_v;
%lsqlin(m, zeros(n_vertices, 1),[],[],)

uv = [u v]
figure 
plotflatmesh(uv, t', vnormals);

offset = 0.00001;
cblen1 = sqr_edge_expected_len/2 - offset;
cblen2 = sqr_edge_expected_len/2 + offset;
n_faces = size(t,2);

orange = [0.8 0.2 0];
blue = [0 0.2 0.8];

face_color = repmat(orange, n_faces, 1);

for i=1:n_faces
    v1 = uv(t(1,i),:);
    v2 = uv(t(2,i), :);
    v3 = uv(t(3,i), :);
    if(v1 < cblen1 | v2< cblen1 | v3 < cblen1) 
        face_color(i,:) = blue;
    end
    if(v1 > cblen2 | v2> cblen2 | v3 > cblen2) 
        face_color(i,:) = blue;
    end
end

options.face_vertex_color = face_color;
figure
fig2 = plotflatmesh(uv, t', vnormals, options);

figure;
fig3 = plotmesh(p',t', options);
