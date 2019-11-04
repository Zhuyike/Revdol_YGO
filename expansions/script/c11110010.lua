--马
function c11110010.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110010,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c11110010.target)
	e1:SetOperation(c11110010.operation)
	c:RegisterEffect(e1)
end
function c11110010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_HAND)
end
function c11110010.filter(c)
	return c:IsAbleToGrave()
end
function c11110010.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local ft=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local g=Duel.SelectMatchingCard(tp,c11110010.filter,tp,LOCATION_HAND,0,1,ft,nil)
	if g:GetCount()>0 then
		local num=Duel.SendtoGrave(g,REASON_COST)
		if Duel.Draw(tp,num,REASON_EFFECT)>0 then
			Duel.BreakEffect()
			Duel.DiscardDeck(tp,1,REASON_EFFECT)
		end
	end
end