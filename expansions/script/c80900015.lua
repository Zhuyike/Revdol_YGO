--罗兹·冲浪·完美发挥
function c80900015.initial_effect(c)
	local e1=Effect.CreateEffect(c) 
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	--e1:SetCondition(c80900015.secon)
	e1:SetTarget(c80900015.setg)
	e1:SetOperation(c80900015.seop)
	c:RegisterEffect(e1)	
end
function c80900015.tgfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD) and c:IsAttackAbove(2000)
end
function c80900015.sefilter(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900015.setg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c80700003.filter(chkc) end
	if chk==0 then return 
	Duel.IsExistingTarget(c80900015.tgfilter,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingMatchingCard(c80900015.sefilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c80900015.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80900015.seop(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c80900015.sefilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
end