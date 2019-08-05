--花生酱
function c60602009.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c60602009.atlimit)
	c:RegisterEffect(e1)

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
	return c:IsFaceup() and (c:IsCode(60602000) or c:IsCode(60602001))
end
function c60602009.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) 
end