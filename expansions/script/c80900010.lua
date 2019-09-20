--清歌·冲浪·巨浪来袭
function c80900010.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c80900010.cost)
	e2:SetTarget(c80900010.target)
	e2:SetOperation(c80900010.operation)
	c:RegisterEffect(e2)	
end
function c80900010.costfilter(c)
	return c:IsAbleToGraveAsCost()  and c:IsRace(RACE_CREATORGOD)
end
function c80900010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
	Duel.IsExistingMatchingCard(c80900010.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c80900010.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c80900010.filter(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
	Duel.IsExistingMatchingCard(c80900010.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp)end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c80900010.operation(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c80900010.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
end