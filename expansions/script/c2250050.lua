--唧唧
function c2250050.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,2250050)
	e1:SetCondition(c2250050.condition)
	e1:SetCost(c2250050.cost)
	e1:SetOperation(c2250050.operation)
	c:RegisterEffect(e1)  
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
   -- e2:SetCountLimit(1,2250051)
	e2:SetTarget(c2250050.thtg)
	e2:SetOperation(c2250050.thop)
	c:RegisterEffect(e2)
end
function c2250050.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and (ph~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c2250050.cfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c2250050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2250050.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250050.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250050.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c2250050.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField()  and chkc:IsAbleToHand() end
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c2250050.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end