--泳装型卡缇娅·乌拉诺娃
function c80900006.initial_effect(c)
	local e1=Effect.CreateEffect(c) 
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c80900006.bkcon1)
	e1:SetTarget(c80900006.bktg)
	e1:SetOperation(c80900006.bkop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c) 
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c80900006.bkcon2)
	e2:SetOperation(c80900006.bkop2)
	c:RegisterEffect(e2)
end
function c80900006.filter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
	and not c:IsSetCard(0xfff6)
end
function c80900006.bkcon1(e)
	return Duel.IsExistingMatchingCard(c80900006.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end 

function c80900006.bkfilter(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900006.bktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
	Duel.IsExistingMatchingCard(c80900006.bkfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c80900006.bkop1(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c80900006.bkfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
end
function c80900006.bkcon2(e)
	return not Duel.IsExistingMatchingCard(c80900006.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end 
function c80900006.bkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end