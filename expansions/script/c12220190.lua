--饺子馅
function c12220190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,12220190+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c12220190.target)
	e1:SetOperation(c12220190.activate)
	c:RegisterEffect(e1)	
end

function c12220190.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(tp,5)
	if chk==0 then return g:FilterCount(Card.IsAbleToRemove,nil)==5 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_DECK)
end
function c12220190.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>7 then ct=5 end
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	Duel.Draw(tp,2,REASON_EFFECT)
end