--练习型罗兹·巴蕾特
function c76000110.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,1,true,true)
	aux.AddContactFusionProcedure(c,aux.TRUE,LOCATION_HAND,0,Duel.SendtoGrave,REASON_EFFECT)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76000110,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_INITIAL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,76000110)
	e1:SetCost(c76000110.cost)
	e1:SetOperation(c76000110.operation)
	c:RegisterEffect(e1)  
end
function c76000110.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SetTargetParam(g:GetFirst():GetCode())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c76000110.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_HAND,nil,ac)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	end
end