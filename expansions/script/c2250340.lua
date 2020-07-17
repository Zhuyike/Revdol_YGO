--琴某人
function c2250340.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250340)
	e1:SetCondition(c2250340.spcon)
	e1:SetOperation(c2250340.spop)
	c:RegisterEffect(e1) 
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,2250341)
	e2:SetTarget(c2250340.setg)
	e2:SetOperation(c2250340.seop)
	c:RegisterEffect(e2)
end
function c2250340.spcfilter(c)
	return c:IsSetCard(0xff05) and not (c:IsPublic() or c:IsCode(2250340))
end
function c2250340.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetMatchingGroupCount(c2250340.spcfilter,tp,LOCATION_HAND,0,1,nil)>0
end
function c2250340.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c2250340.spcfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c2250340.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xff05) and c:IsAbleToGrave()
end
function c2250340.setg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2250340.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c2250340.seop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2250340.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end