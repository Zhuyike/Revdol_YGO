--清歌·泳装
function c80900002.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80900002,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,80900002)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c80900002.sptg)
	e1:SetOperation(c80900002.spop)
	c:RegisterEffect(e1)	
end
function c80900002.spfilter(c,e,tp)
	return c:IsSetCard(0xfff8) and c:IsRace(RACE_CREATORGOD) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsAttackBelow(e:GetHandler():GetAttack()) and not c:IsSetCard(0xfff3)
end
function c80900002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c80900002.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c80900002.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c80900002.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end