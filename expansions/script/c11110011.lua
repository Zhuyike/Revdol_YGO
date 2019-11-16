--镜月muki
function c11110011.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,11110011)
	e1:SetCost(c11110011.cost)
	e1:SetOperation(c11110011.operation)
	c:RegisterEffect(e1)
end

function c11110011.filter(c)
	return c:IsLevelBelow(6) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end

function c11110011.filter2(c,nu)
	return c:IsCode(nu) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end

function c11110011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c11110011.filter,tp,LOCATION_DECK,0,1,nil,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end

function c11110011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end

function c11110011.operation(e,tp,eg,ep,ev,re,r,rp)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c11110011.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local nu=tc:GetCode()
		local hd=Duel.GetMatchingGroup(c11110011.filter2,tp,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_DECK,0,nil,nu)
		Duel.SendtoGrave(Group.__add(tc,hd),REASON_EFFECT)
	end
end
