# MeshParameterization

Parametrization is a key operation for texture mapping and surface coloring (e.g. putting a face picture on
mesh).
Given a surface mesh with boundary:
* Detect mesh boundary loops
* Perform a flattening of the mesh onto the plane while maintaining a low distortion.
* Visualize the flattened mesh using the normal of the original 3D mesh

<br />
<img src="/result.png" alt="" />

## Quick Start

Some example meshes are readily available in /samplemeshes for testing

Run main.m in MATLAB to view original mesh, it's intrinsic parameterization, texture in parameterized(uv) space and the  mesh after mapping texture

## More info

This is a simple implementation of discrete conformal parameterization with boundary constraints as described in the following paper,

Desbrun, Mathieu et al. “Intrinsic Parameterizations of Surface Meshes.” Comput. Graph. Forum 21 (2002): 209-218.



Find the full report [here](/project_presentation.pdf). You can also refer the [project page](https://navamikairanda.wixsite.com/navami/mesh-parameterization) for more information

