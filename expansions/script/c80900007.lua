--玉藻·冲浪·翻车溺水
function c80900007.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c80900007.cost)
	e1:SetTarget(c80900007.target)
	e1:SetOperation(c80900007.activate)
	c:RegisterEffect(e1)	
end
function c80900007.costfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToGraveAsCost()
end
function c80900007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80900007.costfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c80900007.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c80900007.filter(c)
	return  c:IsSetCard(0xfffb) and c:IsAbleToHand()
end
function c80900007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80900007.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80900007.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80900007.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end