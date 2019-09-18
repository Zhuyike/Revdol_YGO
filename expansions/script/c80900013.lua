--卡缇娅·冲浪·双人冲浪
function c80900013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c80900013.spcon)
	e1:SetTarget(c80900013.sptg)
	e1:SetOperation(c80900013.spop)
	c:RegisterEffect(e1)
end
function c80900013.filter_faceup(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c80900013.filter(c,e,tp)
	return c:IsRace(RACE_CREATORGOD) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80900013.spcon(e)
	return Duel.GetMatchingGroupCount(c80900013.filter_faceup,tp,LOCATION_MZONE,0,nil)==1
end 
function c80900013.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c80900013.filter,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetMatchingGroupCount(c80900013.filter_faceup,tp,LOCATION_MZONE,0,nil)==1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c80900013.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c80900013.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_SET_ATTACK)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			e3:SetValue(0)
			tc:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_SET_DEFENSE)
			e4:SetReset(RESET_EVENT+RESETS_STANDARD)
			e4:SetValue(0)
			tc:RegisterEffect(e4)
		end
		Duel.SpecialSummonComplete()
	end
end
