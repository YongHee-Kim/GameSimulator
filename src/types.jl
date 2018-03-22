abstract type Asset end
"""
    Unit
`Unit`은 캐릭터 영웅등. Item을 소지하거나 장착할 수도 있다.
"""
abstract type Unit <: Asset end

"""
    Item
    Currency
    StackItem
    NonStackItem
`Item`은 Account나 Unit이 소지하거나 장착할 수 있다

TODO: 소켓에 박는 `Rune`이나 `보석`은 어떤 타입으로?
"""
abstract type Item         <: Asset end
itemid(x::Asset) = x.id
Base.isless(x::T, y::T2) where {T<:Item, T2<:Item} = isless(itemid(x), itemid(y))

abstract type Currency     <: Item end
Base.convert(::Type{T}, x::Real) where {T<:Currency} = T(x)
zero(x::Currency) = oftype(x,0)
zero(::Type{T}) where {T<:Currency} = convert(T,0)

value(x::Currency) = x.value
isless{T<:Currency}(a::T, b::T) = isless(a.value, b.value)
median{T<:Currency}(v::AbstractArray{T}) = median(value.(x))
Base.:(==)(x::T, y::T) where T <: Currency = value(x) == value(y)

abstract type StackItem    <: Item end
value(x::StackItem) = x.value

isless(a::T, b::T) where {T<:StackItem} = isless(a.value, b.value)
function Base.:(==)(x::T, y::T) where T <: StackItem
    value(x) == value(y) && itemid(x) == itemid(y)
end

abstract type NonStackItem <: Item end




"""
    AbstractInventory
storage 여러개를 가지는 저장고
'struct Inventory <: AbstractInventory' 선언 필요
"""
abstract type AbstractInventory end

"""
    AbstractStorage
개별 Asset 타입별로 1개의 Storage를 가진다.
게임 Module에서 지정해야 함.

TODO: `NonStackStorage{T} where T<:NonStackItem`로 정의하여
      공통 구조로 만들자.
"""
abstract type AbstractStorage end
## Iteration ##
Base.start(x::AbstractStorage) = start(x.data)
Base.next(x::AbstractStorage) = next(x.data)
Base.done(x::AbstractStorage) = done(x.data)
Base.getindex(x::AbstractStorage, args...) = getindex(x.data, args...)
Base.setindex!(x::AbstractStorage, args...) = setindex!(x.data, args...)
Base.length(x::AbstractStorage) = length(x.data)
Base.deleteat!(x::AbstractStorage, inds) = deleteat!(x.data, inds)

"""
    AbstractStats

"""
abstract type AbstractStats end
"""
    AbstractBrain
각종 기억이 필요한 사항을 저장한다.
TODO 우선은 General Purpose가 아니라 상황에 따라
"""
abstract type AbstractBrain end

struct Account
    uid::UInt32
    desc::String
    brain::AbstractBrain
    stats::AbstractStats
    inven::AbstractInventory

    let uid = UInt32(0)
        function Account(desc, brain, stats)
            uid += 1
            new(uid, desc, brain, stats, AbstractInventory(uid))
        end
    end
end


# TODO: GameServer 구조
#
#
# """
#     GameServer(title::String, elapsed::Second)
# 게임서버에 저장된 계정을 tick마다 Gameplay 한다.
# """
# abstract type ServerData end
# struct ServerData
#     info::ServerData
#     accounts::Account
# end





# Fallback -- append! 함수를 사용하기 위해 이렇게 정의하긴 했는데...
Base.length(x::Asset) = 1
Base.start(x::Asset) = false
Base.next(x::Asset, state) = (x, true)
Base.done(x::Asset, state) = state

# isempty(x::Number) = false
# in(x::Number, y::Number) = x == y
#
# size(x::Number) = ()
# size(x::Number,d) = convert(Int,d)<1 ? throw(BoundsError()) : 1
# indices(x::Number) = ()
# indices(x::Number,d) = convert(Int,d)<1 ? throw(BoundsError()) : OneTo(1)
# eltype(::Type{T}) where {T<:Number} = T
# ndims(x::Number) = 0
# ndims(::Type{<:Number}) = 0
# length(x::Number) = 1
# endof(x::Number) = 1
# iteratorsize(::Type{<:Number}) = HasShape()
