--茉莉色的希望
function c12220270.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)  
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c12220270.condition)
	e2:SetTarget(c12220270.target)
	e2:SetOperation(c12220270.operation)
	c:RegisterEffect(e2)   
end
function c12220270.filter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220270.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220270.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0
end
function c12220270.tdfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xff04) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end
function c12220270.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED+LOCATION_GRAVE) and chkc:IsControler(tp) and c12220270.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c12220270.tdfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c12220270.tdfilter,tp,LOCATION_REMOVED+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c12220270.operation(e,tp,eg,ep,ev,re,r,rp)
	local ex,g1=Duel.GetOperationInfo(0,CATEGORY_TODECK)
	if g1:GetFirst():IsRelateToEffect(e) then
		Duel.SendtoDeck(g1,nil,2,REASON_EFFECT)
	end
end