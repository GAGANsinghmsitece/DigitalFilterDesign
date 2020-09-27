# DigitalFilterDesign
Designing digital filter using evolutionary algorithm

Evolutionary algorithms are the algorithms which are based on biological evolution and try to mimic certain behaviours(depending on which algorithm you use) of organism to find most optimal solution for a patrticular algorithm. To know more about them,use [this link](https://en.wikipedia.org/wiki/Evolutionary_algorithm)

## Particle Swarm Optimisation(PSO) Algorithm
This algorithm is based on behaviour of animals which perform works in groups such as fish schooling, insect swarming, bird flocking etc.In this algorithm, each particle act as agent and has a position and velocity with which it moves towards optimal solution in search space(region in which optimum solution may lie). To learn more about PSO algorithm , use [this link](https://en.wikipedia.org/wiki/Particle_swarm_optimization).

## Design of digital filters using PSO algorithm
Conventionally, we are using two methods of filter designing:-

**1)Window Technique:-** In this technique, we do not have accurate preside over cut-off frequencies and transition bandwidth.
**2)Optimal Designing:-** The biggest problem with this technique is that they get stuck in local optima and have slow convergence speed.

Due to problems, we shift our focus towards evolutionary algorithms which are capable of designing filters in a wide range. The code given in this repository demonstrate   filter design using Particle Swarm Optimisation.

## Structure of the Project:-

1)`base.m`:- This file contains algorithm parameters,costfunction, problem parameters and filter under consideration.Since we designed this project using encapsulation,You only need to change parameters or filters in `base.m` and change will be reflected in final result.

2)`PSO.m`:- This file contains PSO implementation enclosed under a function which allow us to call it from other file.

3)`CostFunction.m`:- This file contains a function which compares ideal response and our current evaluated response and return a cost/error associated with it which in turn helps particles to alter their position and velocity.

4)`example.png`:-This file contains a sample output.
