--藻藻真可爱AWSL
function c11110026.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c11110026.target)
	e1:SetOperation(c11110026.activate)
	c:RegisterEffect(e1)	  
end
function c11110026.tgfilter(c,tp)
	return c:IsSetCard(0xff00) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c11110026.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c11110026.tgfilter,tp,LOCATION_DECK,0,1,nil,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c11110026.activate(e,tp,eg,ep,ev,re,r,rp)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c11110026.tgfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	Duel.SendtoGrave(tc,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end