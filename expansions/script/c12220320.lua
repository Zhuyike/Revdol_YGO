--初秋微凉·薄荷
function c12220320.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c12220320.spcon)
	c:RegisterEffect(e1)	
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c12220320.condition)
	e2:SetCost(c12220320.cost)
	e2:SetTarget(c12220320.target)
	e2:SetOperation(c12220320.operation)
	c:RegisterEffect(e2)   
end
function c12220320.spfilter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220320.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220320.spfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0
end
function c12220320.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
		and bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c12220320.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST+REASON_DISCARD)
end
function c12220320.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c12220320.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.Draw(tp,1,REASON_EFFECT)
end
