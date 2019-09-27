--搬砖小妹机器人1号
function c92700150.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c92700150.spcon)
	e1:SetTarget(c92700150.sptg)
	e1:SetOperation(c92700150.spop)
	c:RegisterEffect(e1)  
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,92700150)
	e2:SetCondition(c92700150.secon)
	e2:SetCost(c92700150.secost)
	e2:SetOperation(c92700150.seop)
	c:RegisterEffect(e2)
end
function c92700150.seop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92700150.sefilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c92700150.secost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700150.sefilter_150,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(c92700150.sefilter_160,tp,LOCATION_GRAVE,0,1,nil) end
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c92700150.sefilter_160,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(c,POS_FACEUP,REASON_COST)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c92700150.sefilter(c)
	return c:IsSetCard(0xffff) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c92700150.sefilter_150(c)
	return c:IsCode(92700150) and c:IsAbleToRemoveAsCost()
end
function c92700150.sefilter_160(c)
	return c:IsCode(92700160) and c:IsAbleToRemoveAsCost()
end
function c92700150.secon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c92700150.sefilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(c92700150.sefilter_150,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingMatchingCard(c92700150.sefilter_160,tp,LOCATION_GRAVE,0,1,nil)
end
function c92700150.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
end
function c92700150.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return true end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,LOCATION_DECK)
end
function c92700150.spfilter(c,e,tp)
	return c:IsCode(92700160) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92700150.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(c92700150.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(92700150,0)) then
	   Duel.BreakEffect()
	   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	   local sg=g:Select(tp,1,1,nil)
	   Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end