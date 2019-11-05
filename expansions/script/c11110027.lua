--九天雷霆双脚蹬
function c11110027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c11110027.target)
	e1:SetOperation(c11110027.activate)
	c:RegisterEffect(e1)	 
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c11110027.handcon)
	c:RegisterEffect(e2) 
end
function c11110027.handfilter(c)
	return  c:IsRace(RACE_CREATORGOD) and not c:IsSetCard(0xfff5)
end
function c11110027.desfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c11110027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c11110027.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c11110027.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11110027.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,3,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c11110027.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	if tc and Duel.Destroy(g,REASON_EFFECT)~=0 and tc:IsRace(RACE_CREATORGOD) and tc:IsType(TYPE_MONSTER) then
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end
function c11110027.handcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c11110027.handfilter,tp,0,LOCATION_MZONE,1,nil)>0
end
