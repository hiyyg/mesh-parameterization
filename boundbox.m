function lims=boundbox(v,t)
%returns the bounding box of a mesh 
%v array holding the mesh vertices and t is ate array holding the faces
%clearly t is not needed :)

xmin = nan;
xmax = nan;
ymin = nan;
ymax = nan;
zmin = nan;
zmax = nan;

xd = v(:,1);
yd = v(:,2);
if size(v,2)==2
    zd = 0;
else
    zd = v(:,3);
end

xmin = min(xmin,min(xd(:)));
xmax = max(xmax,max(xd(:)));
ymin = min(ymin,min(yd(:)));
ymax = max(ymax,max(yd(:)));
zmin = min(zmin,min(zd(:)));
zmax = max(zmax,max(zd(:)));
   
if ~isnan(xmin)
  lims = [xmin xmax ymin ymax zmin zmax];
else
  lims = [];
end