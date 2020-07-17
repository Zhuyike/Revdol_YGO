--暮色天空
function c2250120.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250120)
	e1:SetCost(c2250120.cost)
	e1:SetTarget(c2250120.sptg)
	e1:SetOperation(c2250120.spop)
	c:RegisterEffect(e1) 
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c2250120.epcon)
	e2:SetOperation(c2250120.epop)
	c:RegisterEffect(e2)	
end
function c2250120.costfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and 
	c:IsAbleToRemoveAsCost()
end
function c2250120.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250120.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250120.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250120.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c2250120.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c2250120.epcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp
end
function c2250120.epop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c2250120.costfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
		e1:SetCost(c2250120.spcost)
		e1:SetTarget(c2250120.sptg2)
		e1:SetOperation(c2250120.spop2)
		Duel.RegisterEffect(e1,tp)
	else 
		local e2=Effect.CreateEffect(c)
		e2:SetCategory(CATEGORY_POSITION)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetTarget(c2250120.potg)
		e2:SetOperation(c2250120.poop)
		c:RegisterEffect(e2)
	end
end
function c2250120.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c2250120.spfilter(c,e,tp)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250120.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroupCount(c2250120.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c2250120.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c2250120.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
	 Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c2250120.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c2250120.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
