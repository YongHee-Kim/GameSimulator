module GameSimulator

# 게임 시뮬레이터

using Base.Dates

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
    has, add!, remove!

### source files
include("currency.jl")
include("item.jl")
include("account.jl")
    include("gameserver.jl")


"""
GameSimulator 모듈 설명
"""
GameSimulator

end
