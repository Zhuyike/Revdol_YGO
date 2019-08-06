--俄罗斯方块
function c60620001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c60620001.condition)
	e1:SetTarget(c60620001.target)
	e1:SetOperation(c60620001.activate)
	c:RegisterEffect(e1)
end
function c60620001.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() 
end
function c60620001.condition(e,tp,eg,ep,ev,re,r,rp)
		if c==nil then return true end
	local tp=c:GetControler()
	return  Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==5
end
function c60620001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(tp) and c60620001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60620001.filter,tp,0,LOCATION_MZONE,5,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c60620001.filter,tp,0,LOCATION_ONFIELD,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c60620001.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
end
