using Plots

abstract type DeterministicComponent end

@kwdef struct PiecewiseLinear{T<:Float64} <: DeterministicComponent
    u_opt::T = 10.0;
    q_opt::T = 0.0;
    k::T = 1.0
end
@kwdef struct Quadratic{T<:Float64} <: DeterministicComponent
    u_opt::T = 10.0;
    q_opt::T = 0.0;
    k::T = 0.1
end

(it::PiecewiseLinear)(u::Float64)::Float64 = it.q_opt + it.k * abs(u - it.u_opt)
(it::Quadratic)(u::Float64)::Float64 = it.q_opt + it.k * (u - it.u_opt)^2

@kwdef struct ControlObject
    det::DeterministicComponent;
    std::Float64 = 1.0
end

(it::ControlObject)(u::Float64)::Float64 = it.det(u) + it.std*randn();

Q = ControlObject(; det=Quadratic())

plot(u -> Q(u), xlims=(0, 20))
