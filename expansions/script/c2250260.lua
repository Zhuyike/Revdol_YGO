--小树林
function c2250260.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,2250260)
	e1:SetOperation(c2250260.activate)
	c:RegisterEffect(e1) 
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xff05))
	e2:SetValue(600)
	c:RegisterEffect(e2)
   --search
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH) 
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_REMOVE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,2250261)
	e4:SetCondition(c2250260.thcon)
	e4:SetTarget(c2250260.thtg)
	e4:SetOperation(c2250260.thop)
	c:RegisterEffect(e4)
end
function c2250260.thfilter(c)
	return c:IsSetCard(0xff05) and c:IsLevelBelow(6)  and c:IsAbleToHand()
end
function c2250260.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c2250260.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(2250260,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c2250260.cfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250260.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2250260.cfilter,1,nil,tp)
end
function c2250260.thfilter2(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c2250260.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250260.thfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c2250260.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2250260.thfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end