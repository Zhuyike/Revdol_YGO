--佩佩
function c2250150.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250150)
	e1:SetCost(c2250150.cost)
	e1:SetTarget(c2250150.sptg)
	e1:SetOperation(c2250150.spop)
	c:RegisterEffect(e1)   
	--Recover
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c2250150.reccon)
	e2:SetTarget(c2250150.rectg)
	e2:SetOperation(c2250150.recop)
	c:RegisterEffect(e2)  
	--Recover
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_REMOVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,2250151)
	e3:SetTarget(c2250150.target)
	e3:SetOperation(c2250150.recop)
	c:RegisterEffect(e3)	 
end
function c2250150.costfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and 
	c:IsAbleToRemoveAsCost()
end
function c2250150.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250150.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250150.costfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250150.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c2250150.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c2250150.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp
end
function c2250150.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c2250150.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c2250150.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,2000)
end