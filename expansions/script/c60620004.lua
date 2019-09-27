--乾坤一掷
function c60620004.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c60620004.condition)
	e1:SetCost(c60620004.cost)
	e1:SetTarget(c60620004.target)
	e1:SetOperation(c60620004.activate)
	c:RegisterEffect(e1)
end
function c60620004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return true end
	Duel.PayLPCost(tp,0)
end
function c60620004.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and Duel.GetCurrentChain()==0
end
function c60620004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,eg:GetCount(),0,0)
end
function c60620004.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
end