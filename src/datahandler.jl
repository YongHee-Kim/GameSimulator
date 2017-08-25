"""
    smartparse(v::AbstractVector; optimize_memory::Bool=false)

적절한 type으로 parse해줌
TODO: Bool변수 처리 필요
"""
function smartparse(v::AbstractVector; optimize_memory::Bool=false)
    v = smartparse.(v)
    ts = unique(typeof.(v))

    # NA가 있으면 DataArray
    vector_type = in(NAtype, ts) ? DataArray : Array

    ts = filter(x->x != NAtype, ts)
    if length(ts) == 1
        el_type = ts[1]
    else
        el_type = any(map(x->issubtype(x, AbstractString), ts)) ? Any : Float64
    end
    # 메모리 최적화
    if optimize_memory && el_type <: Integer
        el_type = _smartparse_optimize_memory(v)
    end
    return convert(vector_type{el_type, 1}, v)
end

function smartparse(x::AbstractString)
    x = get(tryparse(Float64, x), x)
    isa(x, AbstractFloat) ? smartparse(x) : x
end
smartparse(x::AbstractFloat) = isinteger(x) ? Int(x) : x
smartparse(x) = x

function _smartparse_optimize_memory(v::AbstractVector)
    comp = maximum(filter(!isna, v))
    comp <= typemax(Int8) ? Int8 :
    comp <= typemax(Int16) ? Int16 :
    comp <= typemax(Int32) ? Int32 : Int64
end

"""
    idcash(df::DataFrame, id_colname::Symbol)
지정된 컬럼의 Data로 row를 cash로 생성
itemid등 index를 캐시로 저장
"""
function rowindex_cash(df::DataFrame, id_colname::Symbol)
    ref = df[id_colname]
    Dict(zip(ref, 1:size(ref,1)))
end
