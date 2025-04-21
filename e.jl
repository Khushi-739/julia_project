using ModelingToolkit, DifferentialEquations, Plots

@parameters t
@variables x(t)
D = Differential(t)

# Define the equation
eq = D(x) ~ -x

# Create and simplify the system
@named sys = ODESystem([eq], t, [x], [])
sys_simplified = structural_simplify(sys)

# Initial condition and time span
u0 = [x => 1.0]
tspan = (0.0, 10.0)

# Create and solve the problem
prob = ODEProblem(sys_simplified, u0, tspan)
sol = solve(prob)

# Confirmation messages
println("ODE solved successfully.")
println("Sample of solution values:")
for i in 1:5
    println("t = $(sol.t[i]): x(t) = $(sol.u[i])")
end

using Plots
savefig(plot(sol), "solution_plot.png")
println("Plot saved as solution_plot.png")

