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
	g:GetFirst():RegisterFlagEffect(60602004,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1,cid)
end
function c60602004.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if c:IsRelateToEffect(e)  and tc:IsRelateToEffect(e) and tc:GetFlagEffectLabel(60602004)==cid then
		c:SetCardTarget(tc)
		e:SetLabelObject(tc)
		c:ResetFlagEffect(60602004)
		tc:ResetFlagEffect(60602004)
		local fid=c:GetFieldID()
		c:RegisterFlagEffect(60602004,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		tc:RegisterFlagEffect(60602004,RESET_EVENT+RESETS_STANDARD,0,1,fid)
	   local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW)
		e2:SetLabel(fid)
		e2:SetLabelObject(e1)
		e2:SetCondition(c60602004.rstcon)
		e2:SetOperation(c60602004.rstop)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetCountLimit(1)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW)
		e3:SetLabel(fid)
		e3:SetLabelObject(tc)
		e3:SetCondition(c60602004.agcon)
		e3:SetOperation(c60602004.agop)
		Duel.RegisterEffect(e3,1-tp)

	end
end
function c60602004.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler()) and e:GetHandler():GetFlagEffect(60602004)~=0
end
function c60602004.rstcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if  c:GetFlagEffectLabel(60602004)==e:GetLabel() then
		return not c:IsDisabled()
	else
		e:Reset()
		return false
	end
end
function c60602004.rstop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	Duel.HintSelection(Group.FromCards(e:GetHandler()))
end
function c60602004.agcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(60602004)==e:GetLabel()
		and c:GetFlagEffectLabel(60602004)==e:GetLabel() then
		return not c:IsDisabled()
	else
		e:Reset()
		return false
	end
end
function c60602004.agop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_RULE)
	
end