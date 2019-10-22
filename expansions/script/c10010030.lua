--糯米米
function c10010030.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1,10010030+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c10010030.con)
	e1:SetOperation(c10010030.op)
	c:RegisterEffect(e1)
end
function c10010030.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle() and Duel.GetMatchingGroupCount(c10010030.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)>1
end
function c10010030.filter(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c10010030.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroupCount(c10010030.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c10010030.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,2,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end