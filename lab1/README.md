# Task description
This task required simulation of a simple hybrid  model of a bouncing ball.

The bouncing ball at each moment in time has only 2 properties: it's height
over ground and its speed. Let's consider, that for a ball upward speed is
positive, thus, downward speed will be considered negative. In the most simple
case, which is considered in this work, there are no changing forces that
affect the ball. Hence, the ball is only affected by gravity and its own
"bounciness".

# System description
Having said, that the each ball's state has only 2 properties: speed towards
ground and heightover ground, let's consider $q$ to be height of the ball
over ground and $h$ - speed of the ball towards ground. However, from basic
physics we know, that speed is the first-order derivative of position, hence
we can write: $h = \dot{q}$. It's also worth mentioning, that the acceleration
of the ball is $a = \dot{h} = \ddot{q}$. This will be useful for us in future.

In the case, described above, the behaviour of the bouncing ball can be written,
using only the following DE: $\ddot{q} = -g$, where $g$ is the absolute value of
the acceleration caused by gravity. However, one can reasonably note, that the
ball cannot constantly fall. At some point in time it should bounce. This adds
"hybridness" to our model. If the downward or upward movement of the ball can be
described as continous processes, the bounce is a discrete process.

The conditions for a bounce can be written as $q \le 0$. In case of a bounce,
the ball's properties change. I.e. th speed changes to the same speed in the
opposite direction, reduced by the "bounciness" coefficient. So, the general
system of equations, that describes dynamics of the ball speed, can be written
as follows, considering $\lambda$ is the coefficient of "bounciness":
$$\left\lbrace \matrix {\dot{q} = -g, q > 0 \cr \dot{q} = -\dot{q} \cdot \lambda, q \le 0} \right.$$

This information is enough to create a simulink model of the system, using
hybrid equations toolbox.

# Model in Simulink
First of all, we will use the `HSu` block from the Hybrid system toolbox.
Since our system has no external inputs, we can define parameters for
gravitational acceleration and "bounciness" coefficient and remove the input
pin of the `HSu` block.

The output `x` of this block will be a vector of 2 values: height of the ball
above the ground (`x(1)`) and the speed of the balll towards ground (`x(2)`).

## Definition of flow set
First of all, we should define, which set of possible values our model may have.
The speed of the ball towards ground is, generally, unlimited. But we do know,
that the ball cannot fall below ground level. Hence, our flow set includes only
states in which $q \ge 0$. In matlab code that's defined as:
```matlab
if x(1) >= 0
    output = 1;
else
    output = 0;
end
```

## Definition of a jump set
Jumps in behaviour of our model occur upon the bounces. As it was stated above,
the condition for the bounce is $q \le 0$. As a matlab code it can be written
as:
```matlab
if x(1) <= 0
    jump = 1;
else
    jump = 0;
end
```

## Definition of a flow map
As it was said earlier, height of the ball above the ground changes according
with the ball's speed. And the speed changes always with the acceleration,
caused by gravity. Hence, the flow map can be written as:
```matlab
flow_map = [x(2); -gravity];
```

## Definition of a jump map
As it was said earlier, upon bounce, speed changes to the same speed in the
opposite direction, multiplied by the "bounciness" coefficient. It's also worth
noting, that the height of the ball above ground should also be inverted upon
bounce to mind the errors of zero-comparison. Hence, the matlab code for jump
map is the following:
```matlab
jump_map = [-x(1); -x(2) * bounce];
```
