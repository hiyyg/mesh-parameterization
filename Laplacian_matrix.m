function K = cotanmtx(v,t)
%implement cotan weights Lapalcaian
%returns the laplacian matrix of mesh
nv=size(v,2);
%t(2,:)
%v(:,t(2,:))
vv3=v(:,t(2,:)) - v(:,t(1,:));
vv2=v(:,t(3,:)) - v(:,t(1,:));
vv1=v(:,t(3,:)) - v(:,t(2,:));
%normal to triangle Z=cross(X,V);
nn=[vv3(2,:).*vv2(3,:)-vv3(3,:).*vv2(2,:);...
vv3(3,:).*vv2(1,:)-vv3(1,:).*vv2(3,:);...
vv3(1,:).*vv2(2,:)-vv3(2,:).*vv2(1,:)];
arr= 0.5 * sqrt(nn(1,:).*nn(1,:)+nn(2,:).*nn(2,:)+nn(3,:).*nn(3,:));
c3= -0.25*dot(vv1,vv2)./arr;
c1= -0.25*dot(vv2,vv3)./arr;
c2= 0.25*dot(vv3,vv1)./arr;
clear nn vv1 vv2 vv3 arr
K=sparse(t([1 2 3],:),t([2 3 1],:),[c3; c1; c2],nv,nv);
K=K+K.';
K=K+sparse(t([1 2 3],:),t([1 2 3],:),[-c2-c3; -c3-c1; -c1-c2],nv,nv);