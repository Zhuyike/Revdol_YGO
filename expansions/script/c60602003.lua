--正直者B
function c60602003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60602003.spcon)
	e1:SetOperation(c60602003.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCondition(c60602003.atkcon)
	e2:SetValue(200)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c60602003.descon)
	e3:SetOperation(c60602003.desop)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
end
function c60602003.atkcon(e)
	local phase=Duel.GetCurrentPhase()
	return (phase==PHASE_DAMAGE or phase==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler()
end
function c60602003.spfilter(c,ft)
	return c:IsFaceup() and c:IsCode(60602020) and c:IsAbleToGraveAsCost() and (ft>0 or c:GetSequence()<5)
end
function c60602003.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(c60602003.spfilter,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c60602003.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c60602003.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	 Duel.SendtoGrave(g,REASON_COST)
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e3=e:GetLabelObject()
		if Duel.GetTurnPlayer()==tp then
			c:RegisterFlagEffect(60602003,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,0,1)
			e3:SetLabel(Duel.GetTurnCount()+1)
		end
	end
end
function c60602003.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(60602003)>0 and Duel.GetTurnCount()==e:GetLabel()
end
function c60602003.desop(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(0)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end