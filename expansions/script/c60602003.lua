--正直者B
function c60602003.initial_effect(c)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCondition(c60602003.atkcon)
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c60602003.regop)
	c:RegisterEffect(e4)
end
function c60602003.atkcon(e)
	local phase=Duel.GetCurrentPhase()
	return (phase==PHASE_DAMAGE or phase==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler()
end
function c60602003.subcon(e,tp,eg,ep,ev,re,r,rp)
	return true
end
function c60602003.subop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if (ct==2 or ct>2) then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
function c60602003.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	c:SetTurnCounter(0)
	e1:SetCondition(c60602003.subcon)
	e1:SetOperation(c60602003.subop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,2)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,0,2)
	c60602003[c]=e1
end
