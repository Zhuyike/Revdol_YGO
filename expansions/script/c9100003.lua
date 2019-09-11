--LQG战队
function c9100003.initial_effect(c)
	--sp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9100003,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c9100003.condition)
	e1:SetCost(c9100003.thcost)
	e1:SetTarget(c9100003.thtg)
	e1:SetOperation(c9100003.thop)
	c:RegisterEffect(e1)
end
function c9100003.filter_con(c)
	return c:IsSetCard(0xfff3) and c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c9100003.filter_target(c,e)
	return c:IsSetCard(0xff04) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9100003.filter_cannot_summon(e,c)
	return not c:IsSetCard(0xff04)
end
function c9100003.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c9100003.filter_con,tp,LOCATION_MZONE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c9100003.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler()
	if chk==0 then return tc:IsDiscardable() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SendtoGrave(tc,REASON_COST+REASON_DISCARD)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c9100003.filter_cannot_summon)
	Duel.RegisterEffect(e1,tp)
end
function c9100003.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9100003.filter_target,tp,LOCATION_DECK,0,1,nil,e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c9100003.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c9100003.filter_target,tp,LOCATION_DECK,0,1,1,nil,e)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end