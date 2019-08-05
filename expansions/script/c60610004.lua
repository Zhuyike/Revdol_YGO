--晚香玉色的希望
function c60610004.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c60610004.cost)
	e1:SetTarget(c60610004.target)
	e1:SetOperation(c60610004.activate)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
end
function c60610004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true and Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c60610004.costfilter(c,e,tp)
	return  c:GetOriginalLevel()>0 and Duel.IsExistingMatchingCard(c60610004.spfilter,tp,LOCATION_GRAVE,0,1,nil,c,e,tp) 
		and Duel.GetMZoneCount(tp,c)>0
end
function c60610004.spfilter(c,tc,e,tp)
	return c:GetOriginalLevel()==tc:GetOriginalLevel()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60610004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.CheckReleaseGroup(tp,c60610004.costfilter,1,nil,e,tp)
	end
	e:SetLabel(0)
	local g=Duel.SelectReleaseGroup(tp,c60610004.costfilter,1,1,nil,e,tp)
	Duel.Release(g,REASON_COST)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c60610004.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60610004.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,tc,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end

end
