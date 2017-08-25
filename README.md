# :construction:GameSimulator:construction:


`GameSimulator` 모듈은 게임플레이 시뮬레이션을 위한 프론트엔드를 제공합니다. 게임 런칭전 혹은 업데이트 전에 특정한 플레이 패턴의 유저가 어느 `성장단계`까지 도달할 수 있는지 계산하는게 목표입니다.

## 목표
게임 타이틀별 시뮬레이션을 위해서는 상당히 많은 분량의 전용 프로그램 필요합니다. 또한 타이틀에 따라 필요한 시뮬레이션의 내용과 깊이가 크게 다르기 때문에 게임 시뮬레이션을 위한 완전한 범용 모듈을 제작하는건 불가능합니다. `GameSimulator`는 모든 게임에 공통적으로 활용 가능한 상위 구조를 만드는게 목표입니다. 또한 모든 게임이 공통으로 사용할 수 있는 함수 -재화의 추가 제거 등-를 사전 정의합니다.

## 사용법
`using GameSimulator`로 GameSimulator를 호출해서 각 게임을 백엔드로 `GameServer`와 `Account`의 하위 구조체 및 함수를 정의하여 시뮬레이션을 수행 합니다.


## 현재 기능
현재 없음. 추후 CoC 혹은 BoomBeach 백엔드 모듈을 Sample로 제작할 예정

## 메뉴얼

### 데이터 구조
모든 구조체는 자기 자신의 정보가 있고
그리고 하위 구조체를 담는 Storage가 있다. (스토리지는 각 타입별로 1개씩)
``` julia
struct GameServer
    info::ServerInfo
    accounts::Account
end

struct Account
    # 게임별로 AccountStat, Brain의 하위 구조체 정의
    info::AccountStat
    brain::Brain # GamePlay에서 사용할 DecisionTree

    # 모든 게임 공통 구조 Currency와 Item은 게임별로 정의
    wallet::Dict{DataType, Currency}
    inven_stack::Dict{DataType, StackItem}
    inven_nonstack::Dict{DataType, Vector{NonStackItem}}
end
```

``` julia
# Item을 장착할 수 있는 타입입니다.
abstract Character

# Currency는 1개의 Integer 필드만 가지는 데이터입니다.
abstract Currency

#Currency Item으로 분류합니다
abstract Item
abstract StackItem <: Item
abstract NonStackItem <: Item
```

### 게임플레이 정의
:construction:


## 모듈구조
types.jl -> 구조체와 구조체 생성과 관련됨 함수
io.jl -> 디스플레이 관련됨 함수들
함수는...
query.jl -> 정보, 쿼리 예를들어 가챠폰 뽑기에서 ID는 query에서 가져온다.
gameplay\*.jl -> 콘텐츠 단위별로 구분하여 함수 정의 (UI버튼명을 써버릴까?)

datahandler.jl -> 독립적
