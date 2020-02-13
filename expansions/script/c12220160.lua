--超大声的清歌
function c12220160.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)  
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c12220160.condition)
	e2:SetTarget(c12220160.target)
	e2:SetOperation(c12220160.activate)
	c:RegisterEffect(e2)  
end
function c12220160.filter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220160.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220160.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0
end
function c12220160.remfilter(c)
	return c:IsAbleToRemove()
end
function c12220160.desfilter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL)
end
function c12220160.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c12220160.remfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,nil)>0 and Duel.GetMatchingGroupCount(c12220160.desfilter,tp,0,LOCATION_SZONE,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c12220160.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c12220160.remfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g2=Duel.SelectMatchingCard(tp,c12220160.desfilter,tp,0,LOCATION_SZONE,1,1,nil)
		if g2:GetCount()>0 then
		Duel.Destroy(g2,REASON_EFFECT)
		end
	end
end