--三岁嗔顽
function c60602015.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60602015.spcon)
	e1:SetTarget(c60602015.sptg)
	e1:SetOperation(c60602015.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCost(c60602015.atkcost)
	e2:SetValue(1500)
	c:RegisterEffect(e2)
end
function c60602015.filter(c)
	return c:IsFaceup() and c:IsPosition(POS_ATTACK) 
end
function c60602015.spcon(e,tp,eg,ep,ev,re,r,rp)
	return --Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c60602015.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c60602015.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60602015.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetValue(c60602015.efilter)
		c:RegisterEffect(e1)
		Duel.SpecialSummonComplete()
	end
end
function c60602015.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL) 
end
function c60602015.costfilter(c)
	return  c:IsType(TYPE_SPELL)
end
function c60602015.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60602015.costfilter,tp,LOCATION_HAND,0,1,c) end
	local g=Duel.IsExistingMatchingCard(c60602015.costfilter,tp,LOCATION_HAND,0,1,c)
	Duel.DiscardHand(tp,c60602015.costfilter,1,1,REASON_COST+REASON_DISCARD)
end