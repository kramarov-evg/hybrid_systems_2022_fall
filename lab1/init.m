% Initialization

% Initial state
% x1 -- height of the ball over ground
% x2 -- speed of the ball towards the ground
% x_init -- overall initialization state of the system

x1 = 1;
x2 = 0;
x_init = [x1;x2];

% Global parameters, affecting the whole system
% gravity -- acceleration of the free fall (9.81 for earth ~at equator)
% bounce -- restitution coefficient (system stable if in (0;1))
gravity = 9.81;
bounce = 0.7;

% Simulation limits
% T -- limit in time domain
% J -- limit in jumps domain
T = 100;
J = 20;

% Rule for jumps
rule = 1;

% DE solver tolerances
RelTol = 1e-6;
MaxStep = 1e-6;
