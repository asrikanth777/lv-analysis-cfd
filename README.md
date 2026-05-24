# lv-analysis-cfd

Axisymmetric CFD analysis of the Saturn V launch vehicle across five flight 
conditions from Mach 1.0 to Mach 9.0 using SU2 and Gmsh.

## Overview

This project characterizes wave drag and shock structure over a simplified 
axisymmetric Saturn V geometry across a transonic-to-hypersonic ascent 
trajectory. An inviscid Euler formulation with HLLC flux scheme is used to 
capture pressure-dominated aerodynamic behavior without resolving boundary layers.

Results are validated against Taylor–Maccoll theory at M=4.5, achieving 1.78% 
agreement on bow shock angle.

## Tools
- **Mesh generation:** Gmsh (unstructured, ~1.5M elements)
- **Solver:** SU2 (Euler, HLLC, first-order)
- **Post-processing:** ParaView, Python

## Flight Conditions
| Case | Mach | Altitude (m) |
|------|------|-------------|
| 1    | 1.0  | 1,000       |
| 2    | 2.8  | 2,500       |
| 3    | 4.5  | 5,000       |
| 4    | 6.5  | 15,000      |
| 5    | 9.0  | 30,000      |

## Key Results
- Wave drag decreases from Cd = 0.0743 (M=1.0) to Cd = 0.0110 (M=9.0)
- Transonic drag rise and hypersonic Mach independence captured
- Bow shock validation within 1.78% of Taylor–Maccoll theory at M=4.5

## Limitations
First-order spatial discretization introduces shock smearing that degrades 
shock angle accuracy at M=6.5 and M=9.0 (5–8% error). Viscous effects, 
shock-boundary layer interaction, and high-temperature gas thermochemistry 
are not modeled.
