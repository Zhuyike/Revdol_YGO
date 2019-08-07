--TOP牙膏
function c60602004.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c60602004.efcon)
	e1:SetTarget(c60602004.target)
	e1:SetOperation(c60602004.operation)
	c:RegisterEffect(e1)
end
function c60602004.efcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c60602004.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5
end
function c60602004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE)  end
	if chk==0 then return Duel.IsExistingTarget(c60602004.cfilter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60602004,2))
	local g=Duel.SelectTarget(tp,c60602004.cfilter,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
end
function c60602004.subop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if (ct==2 or ct>2) then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
function c60602004.subcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	local fid=e:GetLabel()
	return c:GetFieldID()==fid
end
function c60602004.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		local fid=c:GetFieldID()
		e1:SetLabel(fid)
		e1:SetLabelObject(c)
		e1:SetCondition(c60602004.subcon)
		e1:SetOperation(c60602004.subop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,2)
		tc:SetTurnCounter(0)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_OPPO_TURN+RESET_SELF_TURN,0,2)
		c60602004[tc]=e1
	end
end