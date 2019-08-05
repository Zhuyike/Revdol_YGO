--寂寞冷花开
function c60602012.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c60602012.target)
	e1:SetOperation(c60602012.operation)
	c:RegisterEffect(e1)
end
function c60602012.filter(c)
	return c:IsFacedown() and c:GetSequence()~=5
end
function c60602012.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c60602012.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60602012.filter,tp,0,LOCATION_SZONE,1,e:GetHandler()) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c60602012.filter,tp,0,LOCATION_SZONE,1,1,e:GetHandler())
end
function c60602012.operation(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local tc=Duel.GetFirstTarget()
		Duel.ConfirmCards(tp,tc)
		if tc:IsType(TYPE_TRAP) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end