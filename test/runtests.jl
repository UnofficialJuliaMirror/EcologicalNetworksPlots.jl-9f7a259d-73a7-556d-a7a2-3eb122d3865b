# Force directed layout -- attempt 1

using EcologicalNetworks
using EcologicalNetworksPlots
using Plots


U = web_of_life("A_HP_001")
K = convert(BinaryNetwork, U)
P = null2(K)
I0 = initial_random_layout(U)
[graph_layout!(U, I0) for i in 1:600]
EcologicalNetworksPlots.finish_layout!(I0)
p1 = plot(K, I0)
savefig(p1, joinpath("..", "gallery", "bipartite_graph.png"))


I1 = initial_bipartite_layout(U)
[bipartite_layout!(U, I1) for i in 1:600]
EcologicalNetworksPlots.finish_layout!(I1)
EcologicalNetworksPlots.spread_levels!(I1; ratio=0.3)
p2 = plot(U, I1)
savefig(p2, joinpath("..", "gallery", "bipartite_bipartite.png"))


Npart = K |> lp |> (x) -> brim(x...)
p3 = plot(K, I1; nodefill=Npart[2], markercolor=:isolum)
savefig(p3, joinpath("..", "gallery", "bipartite_modular.png"))


p4 = plot(K, I0; nodefill=Npart[2], markercolor=:isolum)
savefig(p4, joinpath("..", "gallery", "graph_modular.png"))


p5 = plot(K, I0; nodefill=Npart[2], markercolor=:isolum, bipartite=true)
savefig(p5, joinpath("..", "gallery", "graph_modular_bipartite.png"))


p6 = plot(U, I0; nodefill=Npart[2], nodesize=degree(K), markercolor=:isolum, bipartite=true, msw=0.0)
savefig(p6, joinpath("..", "gallery", "graph_modular_degree_bipartite.png"))
