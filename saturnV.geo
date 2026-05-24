// Saturn V — Axisymmetric, single surface
// Flow left to right, nose at x=0

lc       = 2.5;
lc_body  = lc / 20;
lc_wake  = lc / 8;

// Domain extents
FF_up   = -106.7 * 5;
FF_rad  =  106.7 * 10 ;
FF_down =  106.7 * 20;

// Axis points
Point(1)  = {0,       0,    0, lc_body};  // nose tip
Point(2)  = {106.7,   0,    0, lc_wake}; // base centre
Point(10) = {FF_up,   0,    0, lc};
Point(11) = {FF_down, 0,    0, lc};

// Vehicle profile
Point(3)  = {0,      0.3,   0, lc_body}; // LES tip edge
Point(4)  = {11.7,   1.96,  0, lc_body}; // Apollo base
Point(5)  = {20.1,   3.30,  0, lc_body}; // S-IVB top
Point(6)  = {28.0,   3.30,  0, lc_body}; // S-IVB bottom
Point(7)  = {46.1,   5.03,  0, lc_body}; // S-II top
Point(8)  = {71.1,   5.03,  0, lc_body}; // S-IC top
Point(9)  = {106.7,  5.03,  0, lc_body}; // base edge

// Farfield boundary points
Point(12) = {FF_up,   FF_rad, 0, lc};
Point(13) = {FF_down, FF_rad, 0, lc};

// Axis lines
Line(100) = {10, 1};   // upstream axis
Line(101) = {2, 11};   // downstream axis

// Vehicle wall
Line(1) = {3, 4};
Line(2) = {4, 5};
Line(3) = {5, 6};
Line(4) = {6, 7};
Line(5) = {7, 8};
Line(6) = {8, 9};
Line(7) = {9, 2};    // base face
Line(8) = {1, 3};    // nose tip to LES edge

// Farfield
Line(300) = {10, 12};  // upstream left
Line(301) = {12, 13};  // farfield top
Line(302) = {13, 11};  // outlet right

// Single curve loop
Curve Loop(1) = {
    100,       // upstream axis
    8,         // nose tip to LES edge
    1, 2, 3, 4, 5, 6,  // rocket profile
    7,         // base face
    101,       // downstream axis
    -302,      // outlet reversed
    -301,      // top reversed
    -300       // upstream left reversed
};

Plane Surface(1) = {1};

// Refinement fields
Field[1] = Distance;
Field[1].CurvesList = {1, 2, 3, 4, 5, 6, 7, 8};
Field[1].Sampling = 200;

Field[2] = Threshold;
Field[2].InField  = 1;
Field[2].SizeMin  = lc_body;
Field[2].SizeMax  = lc;
Field[2].DistMin  = 1.0;
Field[2].DistMax  = 80.0;

Field[3] = Box;
Field[3].VIn  = lc_wake;
Field[3].VOut = lc;
Field[3].XMin = 100.0;
Field[3].XMax = 400.0;
Field[3].YMin = 0.0;
Field[3].YMax = 30.0;
Field[3].Thickness = 1.0;

Field[4] = Min;
Field[4].FieldsList = {2, 3};
Background Field = 4;

// Mesh options
Mesh.Algorithm      = 5;
Mesh.RecombineAll   = 0;
Mesh.Optimize       = 1;
Mesh.OptimizeNetgen = 1;
Mesh.MeshSizeExtendFromBoundary = 0;
Mesh.MshFileVersion = 2.2;

// Physical groups
Physical Curve("SYMMETRY", 1) = {100, 101};
Physical Curve("WALL", 2)     = {1, 2, 3, 4, 5, 6, 7, 8};
Physical Curve("FARFIELD", 3) = {300, 301, 302};
Physical Surface("FLUID", 10) = {1};