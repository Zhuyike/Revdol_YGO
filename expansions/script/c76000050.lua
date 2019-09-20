--Swan型罗兹·巴蕾特
function c76000050.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,2,true,true)
	aux.AddContactFusionProcedure(c,nil,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)
	--extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)  
	--Destroy Replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,76000050)
	e2:SetTarget(c76000050.reptg)
	e2:SetValue(c76000050.repval)
	e2:SetOperation(c76000050.repop)
	c:RegisterEffect(e2)  
end
function c76000050.repfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD)
		and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c76000050.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c76000050.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c76000050.repval(e,c)
	return c76000050.repfilter(c,e:GetHandlerPlayer())
end
function c76000050.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end