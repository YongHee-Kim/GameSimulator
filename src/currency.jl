
abstract type Currency end
value(x::Currency) = x.value

# 기본 산술 연산자
+{T<:Currency}(a::T, b::T) = T(a.value + b.value)
-{T<:Currency}(a::T, b::T) = T(a.value - b.value)
*{T<:Currency}(a::T, b::Integer) = T(a.value * b)

isless{T<:Currency}(a::T, b::T) = isless(a.value, b.value)
median{T<:Currency}(v::AbstractArray{T}) = median(value.(x))
