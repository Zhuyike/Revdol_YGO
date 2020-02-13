--素裸天狐·蓝大人
function c12220010.initial_effect(c)
	--cannot select battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c12220010.atlimit)
	c:RegisterEffect(e1)	
	--SpecialSummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1)
	e3:SetCost(c12220010.cost)
	e3:SetTarget(c12220010.sptg)
	e3:SetOperation(c12220010.spop)
	c:RegisterEffect(e3)  
end
function c12220010.atlimit(e,c)
	return c:IsSetCard(0xff04) 
	--and not c:IsCode(12220010)
end
function c12220010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST+REASON_DISCARD)
end
function c12220010.spfilter(c,tc,e,tp)
	return c:IsLevelBelow(6)  and c:IsSetCard(0xff04) and  c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12220010.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroupCount(c12220010.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c12220010.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12220010.spfilter,tp,LOCATION_DECK,0,1,1,nil,tc,e,tp)
	if g:GetCount()>0 then
		local tc2=g:GetFirst()
		if Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(500)
			tc2:RegisterEffect(e1)
		end
		Duel.SpecialSummonComplete()
	end
end