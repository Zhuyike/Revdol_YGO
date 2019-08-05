--咸鸭掌
function c60620006.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60620006.condition)
	e1:SetCost(c60620006.cost)
	e1:SetTarget(c60620006.target)
	e1:SetOperation(c60620006.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetCondition(c60620006.condition)
	e2:SetCost(c60620006.cost)
	e2:SetTarget(c60620006.target)
	e2:SetOperation(c60620006.activate2)
	c:RegisterEffect(e2)
end
function c60620006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return true end
end
function c60620006.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return rp==1-tp 
end
function c60620006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst():GetReasonCard()
	if chk==0 then return true end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,eg,eg:GetCount(),0,0)
end
function c60620006.activate(e,tp,eg,ep,ev,re,r,rp)
   -- local tc=Duel.GetFirstTarget()
	local tc=eg:GetFirst():GetReasonCard()
	if tc:IsRelateToEffect(e) and Duel.GetControl(eg,tp,PHASE_END,2)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		tc:RegisterEffect(e1,true)
	end
end
function c60620006.activate2(e,tp,eg,ep,ev,re,r,rp)
		Duel.GetControl(eg,tp)
end