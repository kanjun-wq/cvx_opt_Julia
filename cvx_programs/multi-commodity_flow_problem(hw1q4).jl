using LinearAlgebra
using JuMP
using MosekTools
#数据输入
# 支路数据
branches = [
1  1  2  1  5;
2  1  3  5  30;
3  4  2  5  30;
4  3  4  1  10;
5  5  3  1  30;
6  5  6  5  30;
7  4  6  1  30;
]
# 节点数据
nodes = [
1  10;
2  -10;
3  0;
4  0;
5  20;
6  -20;
]

# 获取维数
(branches_row, branches_col) = size(branches)
(nodes_row, nodes_col) = size(nodes)

# 生成关联矩阵
A = zeros(nodes_row, branches_row)
for i = 1:nodes_row
    for j = 1:branches_row
        if i == branches[j,2]
            A[i,j] = 1
        end
        if i == branches[j,3]
            A[i,j] = -1
        end
    end
end
# 成本
cost = branches[:,4]
# 上限
u = branches[:,5]
# 节点状态
node_status = nodes[:,2]

LP_model = Model(with_optimizer(Mosek.Optimizer))
@variable(LP_model, f[1:branches_row])
@objective(LP_model, Min, sum(cost.*f))
@constraint(LP_model, f.<=u)
@constraint(LP_model, f.>=0)
@constraint(LP_model, A*f.==node_status)
optimize!(LP_model)
objective_value(LP_model)
value.(f)
println(objective_value(LP_model))
println(value.(f))
# 本文档由王院、杜院指导编写，特此感谢！
