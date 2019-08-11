--罗兹·沙滩·排球对决
function c80900016.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCountLimit(1,80900016)
	e2:SetCondition(c80900016.atkcon)
	e2:SetOperation(c80900016.atkop)
	c:RegisterEffect(e2)	
end
function c80900016.filter(c)
	return c:IsCode(99999999) 
end
function c80900016.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c80900016.filter,tp,0,0,1,nil) --and not c80900016.chain_solving
end
function c80900016.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_CREATORGOD))
	e2:SetValue(500)
	c:RegisterEffect(e2)
end