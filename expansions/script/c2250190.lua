--墨汐的微辣火锅
function c2250190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c2250190.condition)
	e1:SetTarget(c2250190.target)
	e1:SetOperation(c2250190.activate)
	c:RegisterEffect(e1)	
end
function c2250190.cfilter(c,tp)
	return  c:GetPreviousControler()==tp
end
function c2250190.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2250190.cfilter,1,nil,tp)
end
function c2250190.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAbleToDeck()
end
function c2250190.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetMatchingGroupCount(c2250190.filter,tp,0,LOCATION_MZONE,1,c)>0 end
	local sg=Duel.GetMatchingGroup(c2250190.filter,tp,0,LOCATION_MZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c2250190.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c2250190.filter,tp,0,LOCATION_MZONE,aux.ExceptThisCard(e))
	if tg:GetCount()==0 then return end
	if Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)==0 then return end
	local ct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if ct>0 then Duel.SortDecktop(tp,1-tp,ct) end
end

