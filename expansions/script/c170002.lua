--贝拉家的启言
function c170002.initial_effect(c)
	--discard hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170002,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,170002)
	e1:SetCost(c170002.e1co)
	e1:SetTarget(c170002.e1tg)
	e1:SetOperation(c170002.e1op)
	c:RegisterEffect(e1)
	--distory card
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170002,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c170002.e2tg)
	e2:SetOperation(c170002.e2op)
	c:RegisterEffect(e2)
end
function c170002.e1co(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c170002.filter(c)
	return c:IsFacedown()
end
function c170002.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c170002.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c170002.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c170002.filter,tp,nil,LOCATION_SZONE,1,1,e:GetHandler())
end
function c170002.e2op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
		if tc:IsType(TYPE_TRAP) then Duel.Destroy(tc,REASON_EFFECT) end
	end
end
function c170002.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,1-tp,1)
end
function c170002.e1op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):Select(tp,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end