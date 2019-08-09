--罗兹·泳装
function c80900003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80900003,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80900003.spcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(aux.chainreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c80900003.acop)
	c:RegisterEffect(e3)
end
function c80900003.filter(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900003.spcon(e,c,tp)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c80900003.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
end
function c80900003.atkfilter(c)
	return c:IsType(EFFECT_TYPE_ACTIVATE) and c:IsActiveType(TYPE_SPELL) and c:IsControler(tp) and c:IsSetCard(0xfff9)
end
function c80900003.acop(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local g=Duel.GetMatchingGroup(c80900003.atkfilter,tp,LOCATION_ONFIELD,0,1,1,nil,e,tp)
		if g>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(g*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end