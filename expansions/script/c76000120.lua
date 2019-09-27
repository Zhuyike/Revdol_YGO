--练习型卡缇娅·乌拉诺娃
function c76000120.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,1,true,true)
	aux.AddContactFusionProcedure(c,aux.TRUE,LOCATION_HAND,0,Duel.SendtoGrave,REASON_EFFECT)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c76000120.condition)
	c:RegisterEffect(e1)	
end
function c76000120.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD) 
	and not c:IsCode(76000120)
end
function c76000120.condition(e,c,minc)
	local tp=e:GetHandlerPlayer()
	return  Duel.IsExistingMatchingCard(c76000120.filter,tp,LOCATION_MZONE,0,1,nil)
end