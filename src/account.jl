##############################################################################
##
## Currency, Item 추가 제거 return 타입은 Bool
##
##############################################################################
# Currency
has{T<:Currency}(a::Account, x::T) = (a.wallet[T] >= x)
function add!{T<:Currency}(a::Account, x::T)
    (a.wallet[T] += x) #음수 체크를 넣어야 하나?
    true
end
function remove!{T<:Currency}(a::Account, x::T)
    if has(a, x)
        a.wallet[T] -= x
        true
    end
    false
end


# StackItem
get_stackitem(a::Account, id) = filter(x->x.id == id, a.inven_stack[T])

function has{T<:StackItem}(a::Account, x::T)
    y = get_stackitem(a, x.id)
    y.value >= x.value
end
function add!{T<:StackItem}(a::Account, x::T)
    y = get_stackitem(a, x.id)
    y.value += x.value #음수 체크를 넣어야 하나?
    true
end
function remove!{T<:StackItem}(a::Account, x::T)
    y = get_stackitem(a, x.id)
    if y.value >= x.value
        y.value -= x.value
        true
    end
    false
end

# NonStackItem
has{T<:NonStackItem}(a::Account, x::T) = findfirst(a.inven_nonstack[T], x) > 0
function add!{T<:NonStackItem}(a::Account, x::T)
    push!(a.inven_nonstack[T], x)
    true
end
function remove!{T<:NonStackItem}(a::Account, x::T)
    if has(a, x)
        deleteat!(x, findfirst(a.inven_nonstack[T], x))
        true
    end
    false
end
