# 게임별로 인벤토리는 별도 지정
abstract type Inventory end

abstract type Item end
itemid(x::Item) = x.id

# currency는 type으로 구분, StackItem은 ID로 구분
abstract type StackItem <: Item end
value(x::StackItem) = x.value
function +{T<:StackItem}(a::T, b::T)
    itemid(a) != itemid(b) && throw(MethodError(+, (a.id, b.id)))
    T(a.value + b.value)
end
function -{T<:StackItem}(a::T, b::T)
    itemid(a) != itemid(b) && throw(MethodError(-, (a.id, b.id)))
    T(a.value - b.value)
end


# TODO: sorting 위하여 서로 다른 ID의 아이템을 구분할 rule 정의 필요.
# isless{T<:Stackable}(a::T, b::T) = isless(a.value, b.value)

abstract type NonStackItem <: Item end
