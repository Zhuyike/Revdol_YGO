--闪耀的日常
function c92700200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c92700200.condition)
	e1:SetTarget(c92700200.target)
	e1:SetOperation(c92700200.activate)
	c:RegisterEffect(e1)
end
function c92700200.tgfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c92700200.cfilter(c)
	return c:IsCode(99999999) and not c:IsPublic()
end
function c92700200.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c92700200.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  end
	if chk==0 then return Duel.IsExistingTarget(c92700200.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
	and Duel.IsExistingMatchingCard(c92700200.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c92700200.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c92700200.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c92700200.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetValue(c92700200.efilter)
		tc:RegisterEffect(e2)
	end
end
function c92700200.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwner()~=e:GetOwner()
end
