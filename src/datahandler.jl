"""
smartparse
적절한 type으로 parse해줌
"""
function smartparse(v::AbstractVector, optimize_memory = false)
    v = smartparse.(v)
    ts = unique(typeof.(v))

    # NA가 있으면 DataArray
    vector_type = in(NAtype, ts) ? DataArray : Array

    ts = filter(x->x != NAtype, ts)
    el_type = if length(ts) == 1
            ts[1]
        else
            in(String, ts) ? Any : Float64
        end
    end
    # 메모리 최적화
    if optimize_memory
        el_type = _smartparse_optimize_memory(v)
    end
    return convert(vector_type{el_type, 1}, v)
end

function smartparse(x::AbstractString)
    x = get(tryparse(Float64, x), x)
    isa(x, AbstractFloat) ? smartparse(x) : x
end
smartparse(x::AbstractFloat) = isinteger(x) ? Int(x) : x



function _smartparse_optimize_memory(v::AbstractVector)
    comp = maximum(filter(!isna, v))
    comp <= typemax(Int8) ? Int8 :
    comp <= typemax(Int16) ? Int16 :
    comp <= typemax(Int32) ? Int32 : Int64
end
