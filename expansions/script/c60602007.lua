--蠢凌
function c60602007.initial_effect(c)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60602007.spcon)
	e1:SetTarget(c60602007.sptg)
	e1:SetOperation(c60602007.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c60602007.adval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c60602007.deval)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetValue(c60602007.atlimit)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetOperation(c60602007.regop)
	c:RegisterEffect(e5)

end
function c60602007.atlimit(e,c)
	return c:IsFaceup() and (c:IsCode(60602000) or c:IsCode(60602001))
end
function c60602007.filter(c,ft,tp)
	 return c:IsFaceup() 
end
function c60602007.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and (tc:IsCode(60602000) or tc:IsCode(60602001)) and tc:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c60602007.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60602007.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	 Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
end
function c60602007.adval(e,c)
	local g=Duel.GetMatchingGroup(c60602007.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val
	end
end
function c60602007.deval(e,c)
	local g=Duel.GetMatchingGroup(c60602007.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetDefense)
		return val
	end
end
function c60602007.subcon(e,tp,eg,ep,ev,re,r,rp)
	return true
end
function c60602007.subop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if (ct==2 or ct>2) then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
function c60602007.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	c:SetTurnCounter(0)
	e1:SetCondition(c60602007.subcon)
	e1:SetOperation(c60602007.subop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,2)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,0,2)
	c60602007[c]=e1
end
