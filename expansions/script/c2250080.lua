--MOMO黑
function c2250080.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250080)
	e1:SetCost(c2250080.thcost)
	e1:SetTarget(c2250080.thtg)
	e1:SetOperation(c2250080.thop)
	c:RegisterEffect(e1)   
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,2250081)
	e2:SetTarget(c2250080.bktg)
	e2:SetOperation(c2250080.bkop)
	c:RegisterEffect(e2) 
end
function c2250080.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() and Duel.CheckLPCost(tp,500) end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
	Duel.PayLPCost(tp,500)
end
function c2250080.thfilter(c)
	return c:IsCode(2250260)  and c:IsAbleToHand()
end
function c2250080.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2250080.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2250080.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2250080.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c2250080.bkfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsSetCard(0xff05)  and c:IsAbleToHand()
end
function c2250080.bktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField()  and chkc:IsAbleToHand() end
	if chk==0 then return Duel.GetMatchingGroupCount(c2250080.bkfilter,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c2250080.bkfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c2250080.bkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end