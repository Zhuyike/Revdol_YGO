--花生酱
function c60602009.initial_effect(c)
	--atklimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(c60602009.atlimit)
	c:RegisterEffect(e1)
	--IMMUNE_EFFECT
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c60602009.atlimit)
	e2:SetValue(c60602009.efilter)
	c:RegisterEffect(e2)
end
function c60602009.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0xfff6) and c:IsType(TYPE_MONSTER)
end
function c60602009.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) 
end