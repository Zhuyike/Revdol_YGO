--A纸袋
function c60602005.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,60602005)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c60602005.spcost)
	e1:SetTarget(c60602005.sptg)
	e1:SetOperation(c60602005.spop)
	c:RegisterEffect(e1)
	--back to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,60602006)
	e2:SetCondition(c60602005.desth)
	e2:SetTarget(c60602005.thtg)
	e2:SetOperation(c60602005.thop)
	c:RegisterEffect(e2)
end
function c60602005.costfilter(c)
	return  (c:IsCode(60602021) or c:IsCode(60602007))
end
function c60602005.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c60602005.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c60602005.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c60602005.spfilter(c)
	return c:IsCode(60602020) 
end
function c60602005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
		 Duel.IsExistingMatchingCard(c60602005.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end

	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c60602005.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60602005.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
	   Duel.SpecialSummonComplete()
	end
end
function c60602005.desth(e,tp,eg,ep,ev,re,r,rp)
	return  e:GetHandler():IsReason(REASON_BATTLE) 
end
function c60602005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c60602005.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end