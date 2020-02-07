--清歌的钢琴
function c12220220.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1) 
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c12220220.condition)
	e2:SetTarget(c12220220.target)
	e2:SetOperation(c12220220.activate)
	c:RegisterEffect(e2)	   
end
function c12220220.filter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220220.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220220.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0
end
function c12220220.sefilter(c)
	return c:IsSetCard(0xff04) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c12220220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c12220220.sefilter,tp,LOCATION_DECK,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12220220.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c12220220.sefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
