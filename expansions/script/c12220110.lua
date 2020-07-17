--黑心芝麻馅·九不理包子
function c12220110.initial_effect(c)
	  --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_STEP_END)
	e1:SetCountLimit(1,12220110)
	e1:SetCost(c12220110.cost)
	e1:SetCondition(c12220110.spcon)
	e1:SetOperation(c12220110.spop) 
	e1:SetTarget(c12220110.sptg)
	c:RegisterEffect(e1)  
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c12220110.condition)
	e2:SetTarget(c12220110.target)
	e2:SetOperation(c12220110.activate)
	c:RegisterEffect(e2)  
end
function c12220110.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c12220110.spfilter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220110.spcon(e,tp,eg,ep,ev,re,r,rp,chk)   
	local ph=Duel.GetCurrentPhase()
	return  Duel.GetCurrentPhase()==PHASE_BATTLE_STEP and Duel.CheckLPCost(tp,500) and Duel.GetMatchingGroupCount(c12220110.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0 
end
function c12220110.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c12220110.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)  
end
function c12220110.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp 
end
function c12220110.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return at:GetAttack()~=at:GetBaseAttack() and at:IsOnField() and at:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,at,1,0,0)
end
function c12220110.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Destroy(tc,REASON_EFFECT)
end
