--贝拉·沙滩·完美救场
function c80900008.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c80900008.condition)
	e1:SetCost(c80900008.cost)
	e1:SetTarget(c80900008.target)
	e1:SetOperation(c80900008.activate)
	c:RegisterEffect(e1) 
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c80900008.condition2)
	e2:SetCost(c80900008.cost)
	e2:SetTarget(c80900008.target)
	e2:SetOperation(c80900008.activate)
	c:RegisterEffect(e2)   
end
function c80900008.costfilter(c)
	return c:IsCode(99999999) and c:IsAbleToGraveAsCost()
end
function c80900008.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c80900008.condition2(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end
function c80900008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80900008.costfilter,tp,LOCATION_HAND,0,1,c) end
	local g=Duel.IsExistingMatchingCard(c80900008.costfilter,tp,LOCATION_HAND,0,1,c)
	Duel.DiscardHand(tp,c80900008.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c80900008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c80900008.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end