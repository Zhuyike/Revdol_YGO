--不思量·莫相忘
function c12220040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c12220040.condition)
	e1:SetCountLimit(1,12220040)
	e1:SetTarget(c12220040.target)
	e1:SetRange(LOCATION_MZONE) 
	e1:SetOperation(c12220040.activate)
	c:RegisterEffect(e1)   
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,12220041)
	e2:SetCost(c12220040.cost)  
	e2:SetTarget(c12220040.target)
	e2:SetOperation(c12220040.drawop)
	c:RegisterEffect(e2)	
end
function c12220040.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttack()>e:GetHandler():GetBaseAttack()
end
function c12220040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
		and Duel.GetMatchingGroupCount(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c12220040.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	if g:GetCount()<2 or not Duel.IsPlayerCanDraw(tp) then return end
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local dg=g:Select(tp,2,2,nil)
	Duel.SendtoDeck(dg,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
end
function c12220040.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST+REASON_DISCARD)
end
function c12220040.drawop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDraw(tp) then return end
	Duel.Draw(tp,2,REASON_EFFECT)
end