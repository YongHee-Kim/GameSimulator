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
abstract type Currency     <: Asset end
abstract type StackItem    <: Item end
# TODO: sorting 위하여 서로 다른 ID의 아이템을 구분할 rule 정의 필요.
# isless{T<:Stackable}(a::T, b::T) = isless(a.value, b.value)
abstract type NonStackItem <: Item end


"""
    Inventory
storage 여러개를 가지는 저장고
"""
abstract type Inventory end

"""
    Storage
각 Asset 타입별로 1개의 Storage를 가진다.
"""
abstract type Storage end
# TODO: Currency, StackItem..... 등 별로 Storage 공통 구조 정립 필요




abstract type AccountData end
abstract type Brain end

struct Account
    uid::UInt32
    desc::String
    brain::Brain
    # 계정레벨, 경험치 등 게임별로 다른 정보
    data::AccountData
    inven::Inventory
    let uid = UInt32(0)
        function Account(desc="none")
            new(uid += 1, desc, Brain(), AccountData(), Inventory())
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
