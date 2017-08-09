module GameSimulators

# 게임 시뮬레이터
using Base.Dates
import Base: +, -, *, isless, median

export
    # types
    GameServer, ServerInfo,
    Account, AccountInfo, Brain,
    Currency,
    Item, StackItem, NonStackItem,

    # methods
    wallet,
    inven_stack,
    inven_nonstack,
    has, add!, remove!,

    #
    smartparse

### source files
include("datahandler.jl")
include("currency.jl")
include("item.jl")
include("account.jl")
    include("gameserver.jl")


"""
GameSimulator 모듈 설명
"""
GameSimulator

end
