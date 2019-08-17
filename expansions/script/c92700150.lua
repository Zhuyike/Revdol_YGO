--搬砖小妹机器人1号
function c92700150.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c92700150.spcon)
	e1:SetTarget(c92700150.sptg)
	e1:SetOperation(c92700150.spop)
	c:RegisterEffect(e1)  
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c92700150.secost)
	e2:SetTarget(c92700150.setg)
	e2:SetOperation(c92700150.seop)
	c:RegisterEffect(e2)
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
function c92700150.secostfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsCode(92700150,92700160)
end
function c92700150.secost_selector(c,tp,g,sg,i)
	sg:AddCard(c)
	g:RemoveCard(c)
	local flag=false
	if i<2 then
		flag=g:IsExists(c92700150.spcost_selector,1,nil,tp,g,sg,i+1)
	else
		flag=sg:FilterCount(Card.IsCode,nil,92700150)>0
			and sg:FilterCount(Card.IsCode,nil,92700160)>0
	end
	sg:RemoveCard(c)
	g:AddCard(c)
	return flag
end