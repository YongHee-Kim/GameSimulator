# 게임서버에 저장된 계정을 tick마다 Gameplay 한다.
"""
    title::String
    elapsed::Second
"""
type ServerInfo end

immutable GameServer
    info::ServerInfo
    accounts::Account
end
elapsed(x::GameServer) = x.elapsed
title(x::GameServer) = x.info.title

function Base.show(io::IO, x::GameServer)
    print(io,title(x),"\n",
        Dates.CompoundPeriod(elapsed(x)))
end

addaccount!(x::GameServer, ac::Account) = push!(x.accounts, ac)

# Period의 시간이 경과했는지 체크
iselasped(g::GameServer, t::Period) = iselasped(g, convert(Second, t))
iselasped(g::GameServer, t::Second) = elapsed(g) >= t


function tick!(x::GameServer)


end
