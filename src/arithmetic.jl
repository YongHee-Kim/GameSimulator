# 기본 산술 연산자

+{T<:Currency}(a::T, b::T) = T(a.value + b.value)
-{T<:Currency}(a::T, b::T) = T(a.value - b.value)
*{T<:Currency}(a::T, b::Integer) = T(a.value * b)

function +{T<:StackItem}(a::T, b::T)
    itemid(a) != itemid(b) && throw(MethodError(+, (a.id, b.id)))
    T(a.value + b.value)
end
function -{T<:StackItem}(a::T, b::T)
    itemid(a) != itemid(b) && throw(MethodError(-, (a.id, b.id)))
    T(a.value - b.value)
end
