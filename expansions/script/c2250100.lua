--恶魔妈妈
function c2250100.initial_effect(c)
   --tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250100)
	e1:SetCondition(c2250100.drcon)
	e1:SetCost(c2250100.drcost)
	e1:SetTarget(c2250100.drtg)
	e1:SetOperation(c2250100.drop)
	c:RegisterEffect(e1)   
	--SearchCard
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,2250101)
	e2:SetTarget(c2250100.target)
	e2:SetOperation(c2250100.operation)
	c:RegisterEffect(e2)   
end
function c2250100.drfilter(c)
	return  c:IsAbleToHand()
end
function c2250100.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c2250100.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end  
function c2250100.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)  and Duel.GetMatchingGroupCount(c2250100.drfilter,tp,LOCATION_DECK,0,ct,ct,nil)>0 end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	local g=Duel.GetMatchingGroup(c2250100.drfilter,tp,LOCATION_DECK,0,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,ct,0,0)
end
function c2250100.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local g=Duel.GetMatchingGroup(c2250100.drfilter,tp,LOCATION_DECK,0,ct,ct,nil)
	local rg=g:GetFirst()
	for ct=ct,1 do
		ct=ct-1
		rg:getnext()
	end
		Duel.SendtoHand(rg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,rg)
end
function c2250100.filter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c2250100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2250100.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2250100.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2250100.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end