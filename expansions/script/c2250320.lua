--这就是前Swan的实力吗
function c2250320.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Activate(spsummon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c2250320.target)
	e2:SetOperation(c2250320.activate)
	c:RegisterEffect(e2)
end
function c2250320.filter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250320.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c2250320.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	local dg=Duel.GetMatchingGroup(c2250320.filter,tp,LOCATION_MZONE,0,nil)
		if dg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0):Select(tp,1,1,nil)
		Duel.SendtoGrave(g,nil,1,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
