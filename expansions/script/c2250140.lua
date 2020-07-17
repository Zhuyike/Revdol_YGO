--D.Oni
function c2250140.initial_effect(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c2250140.condition)
	e1:SetValue(c2250140.efilter)
	c:RegisterEffect(e1) 
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c2250140.target)
	e2:SetCondition(c2250140.condition2)
	e2:SetOperation(c2250140.activate)
	c:RegisterEffect(e2)
end
function c2250140.efilter(e,te)
	return te:GetOwner()~=e:GetOwner() 
end
function c2250140.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and (ph~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c2250140.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp
		and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c2250140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c2250140.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		local c=e:GetHandler()
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	end
end
