--伊贞之花
function c99999999.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c99999999.con)
	e1:SetOperation(c99999999.op)
	c:RegisterEffect(e1)	
end
function c99999999.con(e,c)
	if c==nil then return true end
	return Duel.GetLP(tp)<=0 
end
function c99999999.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(e:GetHandlerPlayer(),1000,REASON_EFFECT)
end