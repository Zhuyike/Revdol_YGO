--菌菇汤拌饭
function c60602011.initial_effect(c)
		local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c60602011.cost)
	e1:SetTarget(c60602011.drtg)
	e1:SetOperation(c60602011.drop)
	c:RegisterEffect(e1)
end
function c60602011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c60602011.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c60602011.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if   tc:IsType(TYPE_MONSTER) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	elseif tc:IsType(TYPE_SPELL) then
		Duel.Damage(1-tp,3000,REASON_EFFECT)
	elseif tc:IsType(TYPE_TRAP) then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end