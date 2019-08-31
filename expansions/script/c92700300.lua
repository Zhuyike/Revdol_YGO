--五进三选拔
function c92700300.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c92700300.target)
	e1:SetOperation(c92700300.activate)
	c:RegisterEffect(e1)
end
function c92700300.filter1(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToGrave()
end
function c92700300.filter2(c)
	return c:IsAbleToGrave()
end
function c92700300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3)
		and Duel.IsExistingMatchingCard(c92700300.filter1,tp,LOCATION_HAND,0,1,e:GetHandler()) and Duel.IsExistingMatchingCard(c92700300.filter2,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c92700300.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g1=Duel.GetMatchingGroup(c92700300.filter1,p,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c92700300.filter2,p,LOCATION_HAND,0,nil)
	g1:AddCard(g2:GetFirst())
	if g1:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g1:Select(p,2,2,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,3,REASON_EFFECT)
	end
end
