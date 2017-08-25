# Period의 시간이 경과했는지 체크
# iselasped(g::GameServer, t::Period) = iselasped(g, convert(Second, t))
# iselasped(g::GameServer, t::Second) = elapsed(g) >= t
