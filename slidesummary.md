What you should know.
===

Lecture 1b:
==

* Definition of a projective space
  - How to construct it from a vector space

* Homogeneous coordinates of 2D points
  - How to determine the 2D coordinates from a projective element

* Dual homogeneous coordinates of 2D lines
  - How to determine the parameters of the line from a projective element

* How to determine the distance from a point to a line using their homogeneous
  coordinates

* The cross product operator [a]_x of vector a

* Intersecting point from two lines

* Intersection line from two points

* Points and lines at infinity

* Coordinate transformations as linear transformations on homogeneous coordinates
  - Translation and rotation (rigid transformations)
  - Scaling
  - Affine

* How dual homogeneous coordinates of a line transform relative to the
  homogeneous coordinates of a point


Lecture 1c:
==

* Homogeneous coordinates of 3D points
  – How to determine the 3D coordinates from a projective element
* Dual homogeneous coordinates of 3D planes
  – How to determine the parameters of the plane from a projective element
* Points, planes, and lines at infinity
* Parametric representation of 3D line
* Plücker coordinates of 3D line, including dual Plücker coordinates, the duality mapping
* Algebraic relations for the case “point is in a plane”
* How to determine the distance between 3D point x and 3D plane p
* How to determine the point of intersection between plane p and line L
* How to determine the intersecting plane of a point x and line L
* The principle of duality
* Different cases of 3D transformations and their representations in terms of matrices
  – Translation, rotation
  – Rigid transformations
  – Scaling transformations
  – Affine transformations
* The pinhole camera model
  – Can be represented as a 3 × 4 matrix C that maps 3D points to 2D image points
  – Virtual image plane
  – Internal and external parameters, their geometric interpretation
  – How to decompose C into internal and external parameters
  – Normalized camera
  – Cameracentern,Cn=0


Lecture 1d:
==

* Geometric definition of a homography
* Algebraic definition of a homography
* A homography is invertible
* A homography relates points on a 3D plane with positions in the image plane generated from a pinhole camera
* A homography relates image coordinates in multiple images of a single 3D plane
* A homography relates the images taken from a single view point (equivalent cameras)
* Difference between geometric and algebraic error
* Direct Linear Transformation
  – Appliedtotheproblemofestimatingahomography
  – Minimumnumberofcorrespondingpointpairs=4,andwhy
* How DLT is applied to the problem of estimating a homography

Lectrue 1e:
==

* EVD of anti‐symmetric matrices
* EVD of rotation matrices
* The result of making a singular value decomposition of m × n real matrix A
  – Anm×morthogonalmatrixU
  – Anm×ndiagonalmatrixS(non‐negative) – Ann×northogonalmatrixV
  – SuchthatA=USVT
* Definition of singular values and singular vectors
* How to use SVD to solve homogeneous equations:
  Ax=0
* Relation between EVD and SVD
* Pseudo‐inverses
* The Eckard‐Young theorem

Lecture 1f:
==

* We want to determine geometric objects, eg points lines planes homographies,
  cameras etc, from noisy data.

* Leads typically to: Ax = 0, where A is a data dependent matrix and x is the unknown
  dependent matrix and x is the unknown.

* A is affected by noise
  -Measurement noise
  -Image noise, etc.

* The noise appears in the 2D image
  - Or in the coordinates of the 3D points

* It then makes sense to find solutions that minimise geometric errors defined
  in these spaces.
  - Under reasonable assumptions: Maximum likelihood estimates.

* In general: leads to solving non-linear equations
  -Iterative methods are necessary
  -Exception: point/line intersections in 2D

* Instead we can minimise algebraic errors, ||Ax||, defined in the embedding
  space of the homogeneous coordinates.
  -In general: these have no geometric interpretation in the corresponding Euclidean
  space.

* Depending on which constraint we use for x:
  -inhomogeneous method.
  -homogeneous method
    *Characterises the solution (unique/not unique, exists or not)
    *Hartley normalisation
    *Computationally more complex then the inhom. method.

Lecture 1g:
==

* What is SO(3)
* How to represent a 3D rotation in terms of a
  rotation matrix R
* How to represent a 3D rotation in terms of a
  vector and an angle (n, α)
* Rodrigues’formulathatrelatesthetwo
* Howthematrixexponentialmaprelatesso(3) with SO(3)
* How to represent 3D rotations with unit quaternions
