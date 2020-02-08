--崩坏の祝福
function c12220180.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c12220180.condition)
	e1:SetTarget(c12220180.target)
	e1:SetOperation(c12220180.activate)
	c:RegisterEffect(e1)	
end
function c12220180.filter(c)
	return  c:IsSetCard(0xff04)
end
function c12220180.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220180.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil)>3
end
function c12220180.spfilter(c,e,tp)
	return c:IsLevelBelow(10) and c:IsAttribute(ATTRIBUTE_WIND) and c: IsSetCard(0xff04) and  c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12220180.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c12220180.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c12220180.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12220180.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
		   -- e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(1000)
			tc:RegisterEffect(e1)
		end
		Duel.SpecialSummonComplete()
		if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetCountLimit(1)
			e3:SetLabel(tc:GetBaseAttack())
			e3:SetReset(RESET_PHASE+PHASE_END)
			e3:SetOperation(c12220180.damop)
			Duel.RegisterEffect(e3,tp)
		end
	end
end
function c12220180.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,e:GetLabel(),REASON_EFFECT)
end