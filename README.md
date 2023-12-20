# Suspension Design and Analysis 
## AME 30314 (Differential Equations, Vibrations, and Controls I) Final Project

### Overview
The hypothetical context of this project is that, as a vehicle dynamics engineer at a car company, I have been tasked with evluating the performance of the suspension system at current baseline values,

m=250kg

k=6000 kg/m = 6000 • 9.81 N/m

b=5370 N s/m

as well as proposing new ones top strike a balance between ride comfort and maximizing the longevity of the physical components. I use a 1/4 car model (i.e., analyzing only the motion of one wheel). The car in question is the Mazda Miata MX-5.



### Project Breakdown and Notes
* The project is broken up into three parts. A brief description of each part:
    * __Part 0__: build verification tools that provide the expected outputs for simple, known, and previously analyzed scenarios
    * __Part 1__: having inherited code from my boss (my professor) which randomly constructs a road profile, calculate the response of the current spring system, namely its displacement and acceleration
    * __Part 2__: Run many different combinations of suspension parameters (i.e., m,k, and b) to conclude which combination is best for the passenger and for the car.
* MATLAB's built in `ode45()`, which uses fourth-order Runge-Kutta for numerical approximation, is used throughout the project as the underlying computational method
* MathWorks' Statistics and Machine Learning Toolbox is required.

---

#### Part 0
The point of this part is that that I should be able to verify the outputs of my program for simple situations. This is important so that the more complicated and potentially expensive decisions later in the work can be trusted. With this in mind, this part of the project breaks down into four main components:
1. Compute the damper force for a system given m, b, k, F, and ω, where f(t)=Fcos(ωt). I used m=9, b=0.08, k=5, and F=2.
2. Vary initial conditions to see how long the solutions take to reach steady-state.
3. Plot the magnification curve for the damping ratio (ζ=0.006) value which corresponds to my m, k, b, and F values. Pick 4 frequency ratios that correspond to different magnitude responses, and compute the response at those ω values. To ensure that this step is done correctly, I verify that the magnitude of the response matches matches what is predicted by the magnification factor. The four frequency ratios I pick are 0.5, 1, 1.01, and 2. These give us
a good mix of M values (1.33, 83.85, 42.57, and 0.33, respectively).
4. Do the problem in reverse sequence — start with an x(t) and determine by hand what force, f(t), would produce that response function. Plug this f(t) into my program and verify that it outputs the original x(t). I did this twice, once with x(t) = 2cos(3t)-4sin(5t) and once with x(t) = t + 2sin(t).

#### Part 1
Using `makeroad.m` (written by my professor as part of the project starter code), I apply the techniques developed in part 0 to compute the extension & compression (height) of the spring, the maximum acceleration of the car body. This is done in `suspension.m`. For the modelling of the car, I was instructed to use the m, k, and b values specified in the overview section. The findings for this part are summarized in `part_1_summary.pdf` (located in `/part_1/` with the code). Note that a strict three-slide limit was enforced for this part. I verify the results by applying my response computation to a sinusoidal road profile, for which the exact analytical solution is known. I check that the response mathces the expected response at various velocities; this is done in `verification_vel.m`. The magnitude verification disucssed on the last slide of the summary is done in `verification_mag.m`.

#### Part 2
Finally I evaluate, at various velocities, each for the same range of k and b values, the system's performance. I do this by checking every possible combination of (0.5k 0.75k k 1.25k 1.5k) with (0.5b 0.75b b 1.25b 1.5b). This computationally process is run at three velocities, v=15m/s, v=30m/s, and v=45m/s. All computation is done in `optimize  .m`. I state my findings in `part_2_summary.pdf` (located in `/part_2/` with the code), where I justify why I believe that 0.75b and 1.25k is the best combination. The convention I use is that 1b and 1k are their nominal values as specified in the overview section. Note that a strict five-slide limit was enforced for this summary.
