#####
##### AlphaZero.jl
##### Jonathan Laurent, Carnegie Mellon University (2019)
#####

module AlphaZero

export MCTS, MinMax, GameInterface, GI, Report, Network, Benchmark
export Params, SelfPlayParams, LearningParams, ArenaParams
export MctsParams, MemAnalysisParams
export Env, train!, learning!, self_play!, get_experience
export AbstractPlayer, interactive!, MctsPlayer, Human
export ColorPolicy, ALTERNATE_COLORS, BASELINE_WHITE, CONTENDER_WHITE
export Session, resume!, save, explore, play_game, run_new_benchmark
export AbstractNetwork, OptimiserSpec, Momentum, CyclicMomentum
export SimpleNet, SimpleNetHP, ResNet, ResNetHP
export AbstractSchedule, PLSchedule, StepSchedule

include("util.jl")
import .Util
using .Util: Option, @unimplemented

include("game.jl")
import .GameInterface
const GI = GameInterface

include("mcts.jl")
import .MCTS

include("networks/network.jl")
using .Network

include("ui/log.jl")
using .Log

import Plots
import Colors
import JSON2
import JSON3

using Formatting
using Crayons
using Colors: @colorant_str
using ProgressMeter
using Base: @kwdef
using Serialization: serialize, deserialize
using DataStructures: Stack, CircularBuffer
using Distributions: Categorical, Dirichlet
using Statistics: mean

include("schedule.jl")
include("params.jl")
include("report.jl")
include("memory.jl")
include("learning.jl")
include("play.jl")
include("training.jl")

include("minmax.jl")
import .MinMax

include("benchmark.jl")
using .Benchmark

# We support Flux and Knet
const USE_KNET = true

if USE_KNET
  @eval begin
    include("networks/knet.jl")
    using .KNets
  end
else
  @eval begin
    include("networks/flux.jl")
    using .FluxNets
  end
end

include("ui/explorer.jl")
include("ui/plots.jl")
include("ui/json.jl")
include("ui/session.jl")

end
