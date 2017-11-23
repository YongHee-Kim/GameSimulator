+(a::T, b::T) where {T<:Currency} = T(value(a) + value(b))
-(a::T, b::T) where {T<:Currency} = T(value(a) - value(b))
*(a::T, b::Real) where {T<:Currency} = T(value(a) * Int64(b))

function +(a::T, b::T) where {T<:StackItem}
    itemid(a) != itemid(b) && throw(MethodError(+, (a, b)))
    T(itemid(a), value(a) + value(b))
end
function -(a::T, b::T) where {T<:StackItem}
    itemid(a) != itemid(b) && throw(MethodError(-, (a, b)))
    T(itemid(a), value(a) - value(b))
end

"""
    add!(ac::Account, x::Asset)
계정에 아이템을 지급하는 처리.
"""
add!(ac::Account, x::Asset) = add!(ac.inven, x)
add!(ac::Account, xs::AbstractArray{T, 1}) where {T<:Asset} = broadcast(x->add!(ac.inven, x), xs)
"""
    remove!(ac::Account, x::Asset)
    remove!(ac::Account, x::AbstractArray{T, 1}) where {T<:Asset}
계정에 아이템을 삭제하는 처리. 모든 아이템이 있을 경우에만 remove!가능.
"""
remove!(ac::Account, x::Asset) = remove!(ac.inven, x)
function remove!(ac::Account, xs::AbstractArray{T, 1}) where {T<:Asset}
    if has(ac, xs)
        [remove!(ac, x) for x in xs]
        return true
    end
        return false
end
"""
has(ac::Account, x::Asset)
has(ac::Account, x::Vector{T, 1}) where {T<:Asset}
"""
has(ac::Account, x::Asset) = has(ac.inven, x)
has(ac::Account, xs::AbstractArray{T, 1}) where {T<:Asset} = all(broadcast(x->has(ac.inven, x), xs))
