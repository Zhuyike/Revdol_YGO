--猫鱼Ayuri
function c10010040.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c10010040.thcost)
	e1:SetTarget(c10010040.thtg)
	e1:SetOperation(c10010040.thop)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10010040,2))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCountLimit(1,10010040)
	e2:SetCondition(c10010040.condition)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c10010040.target)
	e2:SetOperation(c10010040.operation)
	c:RegisterEffect(e2)
end
function c10010040.filter(c,tp,rp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsSetCard(0xff01) and 1-tp==rp
end
function c10010040.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c10010040.filter,1,nil,tp,rp)
		and Duel.IsChainNegatable(ev)
end
function c10010040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c10010040.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) then
		if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsRelateToEffect(re) then
			Duel.SendtoGrave(eg,REASON_EFFECT)
		end
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
function c10010040.kafilter(c)
	return c:IsSetCard(0xfff6) and c:IsAbleToHand()
end
function c10010040.yafilter(c)
	return c:IsSetCard(0xff01) and c:IsAbleToHand() and (not c:IsCode(10010040))
end
function c10010040.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c10010040.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10010040.kafilter,tp,LOCATION_DECK,0,1,nil) or Duel.IsExistingMatchingCard(c10010040.yafilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c10010040.thop(e,tp,eg,ep,ev,re,r,rp)
	local opt2=Duel.IsExistingMatchingCard(c10010040.kafilter,tp,LOCATION_DECK,0,1,nil)
	local opt1=Duel.IsExistingMatchingCard(c10010040.yafilter,tp,LOCATION_GRAVE,0,1,nil)
	local op=0
	if opt1 and (not opt2) then
		op=Duel.SelectOption(tp,aux.Stringid(10010040,0))
		op=0
	else
		if opt1 and opt2 then
			op=Duel.SelectOption(tp,aux.Stringid(10010040,0),aux.Stringid(10010040,1))
		else
			if (not opt1) and (not opt2) then
				return
			else
				op=Duel.SelectOption(tp,aux.Stringid(10010040,1))
				op=1
			end
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	if op==0 then
		local g=Duel.SelectMatchingCard(tp,c10010040.yafilter,tp,LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		local g=Duel.SelectMatchingCard(tp,c10010040.kafilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end