--伊贞之花
function c99999999.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c99999999.op)
	c:RegisterEffect(e1)	
end
function c99999999.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(e:GetHandlerPlayer(),100,REASON_EFFECT)
end
--function c99999999.activate(e,tp,eg,ep,ev,re,r,rp)
--	math.randomseed(os.time())
--	for i=1,5 do
--	print(math.random())
--	end
--end