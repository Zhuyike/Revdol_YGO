--LYL伊贞联盟
function c9100009.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c9100009.condition)
	e1:SetCost(c9100009.cost)
	e1:SetTarget(c9100009.target)
	e1:SetOperation(c9100009.activate)
	c:RegisterEffect(e1)
end
function c9100009.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xfff7)
end
function c9100009.filter_zhandui(c)
	return c:IsSetCard(0xff03) and c:IsAbleToHand()
end
function c9100009.filter_cannot_summon(e,c)
	return not c:IsSetCard(0xfff7)
end
function c9100009.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(c9100009.filter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(c9100009.filter,tp,0,LOCATION_MZONE,nil)
	return ct1<ct2 and Duel.IsExistingMatchingCard(c9100009.filter_zhandui,tp,LOCATION_DECK,0,1,nil)
end
function c9100009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct1=Duel.GetMatchingGroupCount(c9100009.filter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(c9100009.filter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return ct1<ct2 and Duel.IsExistingMatchingCard(c9100009.filter_zhandui,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c9100009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct1=Duel.GetMatchingGroupCount(c9100009.filter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(c9100009.filter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return ct1<ct2 and Duel.IsExistingMatchingCard(c9100009.filter_zhandui,tp,LOCATION_DECK,0,1,nil) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c9100009.filter_cannot_summon)
	Duel.RegisterEffect(e1,tp)
end
function c9100009.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c9100009.filter_zhandui,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
	end
end
