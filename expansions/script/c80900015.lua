--罗兹·冲浪·完美发挥
function c80900015.initial_effect(c)
	local e1=Effect.CreateEffect(c) 
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c80900015.setg)
	e1:SetOperation(c80900015.seop)
	c:RegisterEffect(e1)	 
end
function c80900015.tgfilter1(c)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD)
end
function c80900015.sefilter1(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900015.sefilter2(c,e,tp)
	return c:IsType(TYPE_SPELL) and c:IsSetCard(0xfff9)
	and not c:IsCode(80900015)
end
function c80900015.setg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c80900015.tgfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80900015.tgfilter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c80900015.tgfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,tp,LOCATION_MZONE)
end
function c80900015.seop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:GetAttack()>=2000 then
			if Duel.IsExistingMatchingCard(c80900015.sefilter1,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c80900015.sefilter2,tp,LOCATION_DECK,0,1,nil,e,tp) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g1=Duel.SelectMatchingCard(tp,c80900015.sefilter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g2=Duel.SelectMatchingCard(tp,c80900015.sefilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
				g1:Merge(g2)
				Duel.SendtoHand(g1,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,g1)
			end
		end
		if tc:GetAttack()<=2000 then
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end