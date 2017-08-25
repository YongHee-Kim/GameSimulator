Base.convert(::Type{T}, x::Real) where {T<:Currency} = T(x)
zero(x::Currency) = oftype(x,0)
zero(::Type{T}) where {T<:Currency} = convert(T,0)

value(x::Currency) = x.value


isless{T<:Currency}(a::T, b::T) = isless(a.value, b.value)
median{T<:Currency}(v::AbstractArray{T}) = median(value.(x))
