"""
GameSimulator 모듈 설명
"""
module GameSimulator

import Base: +, -, *, isless, median, zero

using Base.Dates
using DataFrames
using TextParse


### source files
include("types.jl")
    # 분류가 명확하지 않은 함수들
    include("etc.jl")

# Base.Dates 모듈의 구조를 참조
include("accessors.jl")
include("query.jl")
include("arithmetic.jl")
# include("io.jl")

include("datahandler.jl")



export
    # datahandler
    smartparse, rowindex_cash,

    # types
    Asset, Item, StackItem, NonStackItem,
           Currency,
           Unit,
    Account, AbstractStats, AbstractBrain,
    AbstractInventory, AbstractStorage,

    # methods
    itemid, value,
    add!, remove!, has

end
