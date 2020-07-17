--奶茶屋
function c2250160.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)  
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,2250160)
	e2:SetTarget(c2250160.target)
	e2:SetOperation(c2250160.operation)
	c:RegisterEffect(e2)
   --search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH) 
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,2250161)
	e3:SetCondition(c2250160.thcon)
	e3:SetTarget(c2250160.thtg)
	e3:SetOperation(c2250160.thop)
	c:RegisterEffect(e3)
end
function c2250160.filter(c)
	return c:IsAbleToRemove()
end
function c2250160.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetDecktopGroup(tp,1)
		local tc=g:GetFirst()
		return tc and tc:IsAbleToRemove() and Duel.GetMatchingGroupCount(c2250160.cfilter,tp,LOCATION_MZONE,0,1,nil) end	
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,rg,1,0,0)
end
function c2250160.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if c:IsFaceup() and c:IsRelateToEffect(e) then
	local rg=Duel.SelectTarget(tp,c2250160.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
		local dc=rg:GetFirst()
		local e1=Effect.CreateEffect(dc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		dc:RegisterEffect(e1)
	end
end
function c2250160.cfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250160.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2250160.cfilter,1,nil,tp)
end
function c2250160.thfilter2(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c2250160.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250160.thfilter2,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c2250160.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2250160.thfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
