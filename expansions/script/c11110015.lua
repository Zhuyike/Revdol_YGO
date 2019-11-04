--远川有凌
function c11110015.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110015,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,11110015)
	e1:SetCost(c11110015.thcost)
	e1:SetTarget(c11110015.thtg)
	e1:SetOperation(c11110015.thop)
	c:RegisterEffect(e1)
end
function c11110015.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.ConfirmCards(1-tp,e:GetHandler())
end
function c11110015.thfilter(c)
	return c:IsCode(11110015)
end
function c11110015.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5)
end
function c11110015.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SendtoDeck(c,tp,2,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local g=Duel.GetDecktopGroup(tp,5)
		Duel.Draw(tp,5,REASON_EFFECT)
		if g:IsExists(c11110015.thfilter,1,nil) then
			local op=Duel.SelectOption(tp,aux.Stringid(11110015,1),aux.Stringid(11110015,2))
			if op==0 then
				local tc=g:SearchCard(c11110015.thfilter)
				Duel.ConfirmCards(1-tp,tc)
			else
				local tg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
				Duel.SendtoDeck(tg,tp,2,REASON_EFFECT)
			end
		else
			local tg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
			Duel.SendtoDeck(tg,tp,2,REASON_EFFECT)
		end
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end