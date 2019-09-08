--罗兹·沙滩·排球对决
function c80900016.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCountLimit(1,80900016)
	e2:SetCondition(c80900016.atkcon)
	e2:SetTarget(c80900016.target)
	e2:SetOperation(c80900016.atkop)
	c:RegisterEffect(e2)
	-- search card
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,80910016)
	e3:SetCondition(c80900016.secon)
	e3:SetTarget(c80900016.setarget)
	e3:SetOperation(c80900016.seop)
	c:RegisterEffect(e3)
end
function c80900016.seop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80900016.sefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
	end
end
function c80900016.secon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c80900016.filter,1,nil,tp)
end
function c80900016.sefilter(c)
	return c:IsSetCard(0xfff7) and c:IsType(TYPE_MONSTER)
end
function c80900016.setarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c80900016.sefilter,tp,LOCATION_DECK,0,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80900016.filter(c)
	return c:IsCode(99999999) and c:IsControler(tp)
end
function c80900016.atkfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c80900016.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c80900016.filter,1,nil,tp)
end
function c80900016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetMatchingGroupCount(c80900016.atkfilter,tp,LOCATION_MZONE,0,nil)>0 then
		Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,0,tp,LOCATION_MZONE)
	end
end
function c80900016.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c80900016.atkfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		while gc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(500)
			gc:RegisterEffect(e1)
			gc=g:GetNext()
		end
	end
end