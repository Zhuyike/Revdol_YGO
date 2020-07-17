--鱼香肉丝
function c2250250.initial_effect(c)
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,2250250)
	e1:SetTarget(c2250250.drawtg)
	e1:SetOperation(c2250250.drawop)
	c:RegisterEffect(e1)	
end
function c2250250.cfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250250.drawtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetMatchingGroupCount(c2250250.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0 end
	local g=Duel.SelectTarget(tp,c2250250.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c2250250.drawop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ex,tg=Duel.GetOperationInfo(0,CATEGORY_REMOVE)
	if tg:GetFirst():IsRelateToEffect(e) then
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT) 
	end
		Duel.Draw(tp,2,REASON_EFFECT)
end