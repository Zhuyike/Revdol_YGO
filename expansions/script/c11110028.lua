--樱花色的希望
function c11110028.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	--e1:SetCountLimit(1,11110028)
	e1:SetCondition(c11110028.thcon)
	e1:SetTarget(c11110028.thtg)
	e1:SetOperation(c11110028.thop)
	c:RegisterEffect(e1)	
end
function c11110028.filter(c)
	return c:IsSetCard(0xfff5) and c:IsType(TYPE_MONSTER)
end
function c11110028.thcon(e,c)
	if c==nil then return true end
	return  Duel.GetMatchingGroupCount(c11110028.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)>0
end
function c11110028.thfilter(c)
	return c:IsAbleToHand()
end
function c11110028.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c11110028.thfilter,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c11110028.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11110028.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end