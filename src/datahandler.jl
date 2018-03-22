function _smartparse_optimize_memory(v::AbstractVector)
    comp = maximum(filter(!isna, v))
    comp <= typemax(Int8) ? Int8 :
    comp <= typemax(Int16) ? Int16 :
    comp <= typemax(Int32) ? Int32 : Int64
end

"""
    rowindex_cash(df::DataFrame, key_cols)
지정된 컬ata로 row를 cash로 생성
"""
function rowindex_cash(df::DataFrame, col::Symbol)
    ref = df[col]
    Dict(zip(ref, 1:size(ref,1)))
end
function rowindex_cash(df::DataFrame, key_cols::Vector{Symbol})
    ref = convert(Array, df[:, key_cols])
    key = broadcast(n->tuple(ref[n, :]...), 1:size(ref, 1))
    Dict(zip(key, 1:size(ref, 1)))
end
