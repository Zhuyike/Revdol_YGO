--A纸袋
function c60602005.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c60602005.spcost)
	e1:SetTarget(c60602005.sptg)
	e1:SetOperation(c60602005.spop)
	c:RegisterEffect(e1)
	
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c60602005.desth)
	e2:SetTarget(c60602005.thtg)
	e2:SetOperation(c60602005.thop)
	c:RegisterEffect(e2)
end
function c60602005.spfilter(c)
	return c:IsCode(60602020) 
end
function c60602005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
		 Duel.IsExistingMatchingCard(c60602005.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end

	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c60602005.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60602005.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
 
	   Duel.SpecialSummonComplete()
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		tc:RegisterEffect(e1,true) 
	end
end
function c60602005.cosfit(c)
return c:IsType(TYPE_TOKEN) and c:IsCode(60602022)
end
function c60602005.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c60602005.cosfit,1,nil,TYPE_TOKEN) end
	local g=Duel.SelectReleaseGroup(tp,c60602005.cosfit,1,1,nil,TYPE_TOKEN)
	Duel.Release(g,REASON_COST)
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