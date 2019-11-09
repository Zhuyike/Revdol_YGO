--柳箬凝雪
function c11110003.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110003,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,11110003)
	e1:SetCost(c11110003.condition)
	e1:SetTarget(c11110003.target)
	e1:SetOperation(c11110003.operation)
	c:RegisterEffect(e1)
end
function c11110003.spfilter(c,code,tp,e)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11110003.cfilter(c,tp,e)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp and c:IsSetCard(0xff00) and Duel.IsExistingMatchingCard(c11110003.spfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),tp,e)
end
function c11110003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c11110003.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11110003.cfilter,1,nil,tp,e)
end
function c11110003.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=eg:SearchCard(c11110003.cfilter,tp,e)
	local g=Duel.SelectMatchingCard(tp,c11110003.spfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode(),tp,e)
	if g:GetCount()~=0 then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
			Duel.BreakEffect()
			Duel.DiscardDeck(tp,1,REASON_EFFECT)
		end
	end
end
