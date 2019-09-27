--寂寞冷花开
function c60602012.initial_effect(c)
	--distory card
	local e1=Effect.CreateEffect(c)
	math.randomseed(100)
	local randomint = math.random(100)
	e1:SetDescription(aux.Stringid(60602012,0))
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(randomint)
	e1:SetCountLimit(1)
	e1:SetTarget(c60602012.e1tg)
	e1:SetOperation(c60602012.e1op)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60602012,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetLabel(randomint)
	e2:SetCondition(c60602012.e2con)
	e2:SetTarget(c60602012.e2tg)
	e2:SetOperation(c60602012.e2op)
	c:RegisterEffect(e2)
end
function c60602012.e2op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
	end
end
function c60602012.filter2(c,e,tp)
	return c:GetFlagEffect(60602012+e:GetLabel())>0
end
function c60602012.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60602012.filter2,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c60602012.filter2,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND+CATEGORY_LEAVE_GRAVE,g,1,1-tp,LOCATION_GRAVE)
end
function c60602012.e2con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c60602012.e1con(e,tp,eg,ep,ev,re,r,rp)
	return true
end
function c60602012.filter(c)
	return c:IsFacedown()
end
function c60602012.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c60602012.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c60602012.filter,tp,0,LOCATION_SZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c60602012.filter,tp,nil,LOCATION_SZONE,1,1,e:GetHandler())
end
function c60602012.e1op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
		if tc:IsType(TYPE_TRAP) then
			Duel.Destroy(tc,REASON_EFFECT)
			tc:RegisterFlagEffect(60602012+e:GetLabel(),RESET_EVENT+RESET_TOHAND,0,1)
		end
	end
end