#
# Options
#
@doc raw"""
    ParticleSwarmOptions{P,T} <: Options

Describes a particle swarm optimizing algorithm, with

# Fields
a default value is given in brackets if a parameter can be left out in initialization.

* `x0` – a set of points (of type `AbstractVector{P}`) on a manifold as starting particle positions
* `velocity` – a set of tangent vectors (of type `AbstractVector{T}`) representing the velocities of the particles
* `inertia` – the inertia of the patricles, defaults to 0.65
* `social_weight` – a social weight factor, defaults to 1.4
* `cognitive_weight` – a cognitive weight factor, defaults to 1.4
* `stopping_criterion` – (`[`StopWhenAny`](@ref)`(`[`StopAfterIteration`](@ref)`(500), `[`StopWhenChangeLess`](@ref)`(10^{-4})))
  a [`StoppingCriterion`](@ref)
* `retraction_method` – ([`ExponentialRetraction`](@ref)) the rectraction to use, defaults to
  the exponential map
* `inverse_retraction_method` - ([`LogarithmicInverseRetraction`](@ref)) an `inverse_retraction(M,x,y)` to use.

# Constructor

    ParticleSwarmOptions(x0, velocity, inertia, social_weight, cognitive_weight, stopping_criterion[, retraction_method=ExponentialRetraction(), inverse_retraction_method=LogarithmicInverseRetraction()])

construct a particle swarm Option with the fields and defaults as above

# See also
[`particle_swarm`](@ref)
"""
mutable struct ParticleSwarmOptions{P,T} <: Options
    x::AbstractVector{P}
    p::AbstractVector{P}
    g::P
    velocity::AbstractVector{T}
    inertia::Real
    social_weight::Real
    cognitive_weight::Real
    stopping_criterion::StoppingCriterion
    retraction_method::AbstractRetractionMethod
    inverse_retraction_method::AbstractInverseRetractionMethod
    function ParticleSwarmOptions{P,T}(
        x0::AbstractVector{P},
        velocity::AbstractVector{T},
        inertia::Real = 0.65,
        social_weight::Real = 1.4,
        cognitive_weight::Real = 1.4,
        stopping_criterion::StoppingCriterion = StopWhenAny(StopAfterIteration(500), StopWhenChangeLess(10.0^(-4))),
        retraction_method::AbstractRetractionMethod=ExponentialRetraction(),
        inverse_retraction_method::AbstractInverseRetractionMethod=LogarithmicInverseRetraction(),
    ) where {P}
        o = new{P}();
        o.x = x0;
        o.p = deepcopy(x0);
        o.velocity = velocity;
        o.inertia = inertia;
        o.social_weight = social_weight;
        o.cognitive_weight = cognitive_weight;
        o.stopping_criterion = stopping_criterion;
        o.retraction_method = retraction_method;
        o.inverse_retraction_method = inverse_retraction_method;
        return o
    end
end
function ParticleSwarmOptions(
    x0::AbstractVector{P},
    velocity::AbstractVector{T},
    inertia::Real = 0.65,
    social_weight::Real = 1.4,
    cognitive_weight::Real = 1.4,
    stopping_criterion::StoppingCriterion = StopWhenAny(StopAfterIteration(500), StopWhenChangeLess(10.0^(-4))),
    retraction_method::AbstractRetractionMethod = ExponentialRetraction(),
    inverse_retraction_method::AbstractInverseRetractionMethod=LogarithmicInverseRetraction(),
) where {P,T}
    return ParticleSwarmOptions{P,T}(x0,velocity,inertia,social_weight,cognitive_weight,stopping_criterion,retraction_method,inverse_retraction_method)
end