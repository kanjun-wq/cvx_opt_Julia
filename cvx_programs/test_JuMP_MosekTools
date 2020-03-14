using JuMP, MosekTools
function LP_example()
    # creat an optimization model named "testmodel"
    # set optimization solver
    testmodel = Model(with_optimizer(Mosek.Optimizer))
    # define decision variables
    @variable(testmodel,0<=x<=2)
    @variable(testmodel,0<=y<=30)
    # define objective function
    @objective(testmodel,Max,5x+3y)
    # define constraints
    @constraint(testmodel,con,x+5y<=3)
    # print the optimization model
    print(testmodel)
    # solve the optimization model
    optimize!(testmodel)
    # print results
    println("Optimal objective value is: ",objective_value(testmodel))
    println("Solution is:")
    println("x = ", value.(x))
    println("y = ", value.(y))
end

LP_example()
