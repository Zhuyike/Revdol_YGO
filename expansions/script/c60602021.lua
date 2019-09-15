--无奈Xx(秃头)
function c60602021.initial_effect(c)
	--SpecialSummon1
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,60602021)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c60602021.spcon1)
	e1:SetTarget(c60602021.sptg)
	e1:SetOperation(c60602021.spop)
	c:RegisterEffect(e1)
	--SpecialSummon2
	local e2=e1:Clone()
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c60602021.spcon2)
	c:RegisterEffect(e2)
end
function c60602021.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c60602021.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c60602021.filter(c,e,tp)
	return  c:IsCode(60602021) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60602021.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c60602021.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c60602021.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60602021.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end