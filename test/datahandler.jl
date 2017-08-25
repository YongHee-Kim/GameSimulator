using Base.Test
using GameSimulator

PATH = joinpath(dirname(@__FILE__), "data")

dt = readcsv("$PATH\\smartparse.csv")

@test eltype(smartparse(dt[2:end, 1])) <: AbstractString
@test eltype(smartparse(dt[2:end, 2])) == Any
@test eltype(smartparse(dt[2:end, 3])) == Any
@test eltype(smartparse(dt[2:end, 4])) <: AbstractString

@test eltype(smartparse(dt[2:end, 5])) == Int
@test eltype(smartparse(dt[2:end, 5]; optimize_memory=true)) == Int32
@test eltype(smartparse(dt[2:end, 6])) == Float64

@test eltype(smartparse(dt[2:end, 7])) <: AbstractString

@test eltype(smartparse(dt[2:end, 8])) <: AbstractString
