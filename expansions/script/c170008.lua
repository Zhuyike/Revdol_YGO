--傻贝家der AX_忆白
function c170008.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetCode(EFFECT_CANNOT_DISEFFECT)
	e1:SetValue(c170008.effectfilter)
	c:RegisterEffect(e1)
	Duel.RegisterFlagEffect(tp,170008,0,0,1)

	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_DISABLE)
	e2:SetTarget(c170008.distarget)
	c:RegisterEffect(e2)
end
function c170008.distarget(e,c)
	return (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)) and c:IsFaceup()
end
function c170008.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_LOCATION)
	c=te:GetHandler()
	return (c:IsType(TYPE_TRAP) or c:IsType(TYPE_SPELL)) and c:IsFaceup() and bit.band(loc,LOCATION_SZONE)~=0
end