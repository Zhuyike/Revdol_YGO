--paradox
function c10010020.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10010020,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,10010020)
	e1:SetTarget(c10010020.target)
	e1:SetOperation(c10010020.operation)
	c:RegisterEffect(e1)
	--totop
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10010020,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,10010021)
	e2:SetCondition(c10010020.condition)
	e2:SetCost(c10010020.cost)
	e2:SetOperation(c10010020.operation2)
	c:RegisterEffect(e2)
end
function c10010020.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10010020.yachifilter,tp,LOCATION_MZONE,0,2,nil) and Duel.IsExistingMatchingCard(c10010020.yayafilter,tp,LOCATION_DECK,0,1,nil)
end
function c10010020.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10010020.yachifilter,tp,LOCATION_MZONE,0,1,1,c)
	if Duel.Remove(c,POS_FACEUP,REASON_EFFECT)>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RESOLVECARD)
		local gc=Duel.SelectMatchingCard(tp,c10010020.yayafilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=gc:GetFirst()
		if tc then
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,0)
			Duel.ConfirmDecktop(tp,1)
		end
	end
end
function c10010020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c10010020.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c10010020.splimit(e,c)
	return not c:IsRace(RACE_CREATORGOD)
end
function c10010020.yachifilter(c)
	return c:IsFaceup() and c:IsSetCard(0xff01) and c:IsAbleToRemove()
end
function c10010020.yayafilter(c)
	return c:IsSetCard(0xfff6)
end
function c10010020.spfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD) 
end
function c10010020.selffilter(c,e,tp)
	return c:IsCode(10010020) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10010020.tofilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToHand()
end
function c10010020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return (not Duel.IsExistingMatchingCard(c10010020.spfilter,tp,LOCATION_MZONE,0,1,nil)) and Duel.IsExistingMatchingCard(c10010020.selffilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10010020.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Release(c,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10010020.selffilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 and Duel.IsExistingMatchingCard(c10010020.tofilter,tp,LOCATION_DECK,0,1,nil) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local gc=Duel.SelectMatchingCard(tp,c10010020.tofilter,tp,LOCATION_DECK,0,1,1,nil)
			Duel.SendtoHand(gc,nil,REASON_EFFECT)
		end
	end
end
