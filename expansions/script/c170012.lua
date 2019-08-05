--柴柴桑
function c170012.initial_effect(c)
	--deck to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170012,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c170012.e1tg)
	e1:SetOperation(c170012.e1op)
	c:RegisterEffect(e1)
	--grave to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170012,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c170012.e2con)
	e2:SetTarget(c170012.e2tg)
	e2:SetOperation(c170012.e2op)
	c:RegisterEffect(e2)
end
function c170012.e2op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

function c170012.e2tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c170012.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170012.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c170012.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c170012.e2con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK)
end
function c170012.filter2(c)
	return c:IsSetCard(0xfff0) and c:IsAbleToHand()
end
function c170012.filter(c)
	return c:IsSetCard(0xfff0)
end
function c170012.e1tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc~=c end
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,3,0,LOCATION_DECK)
end
function c170012.e1op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	if g:GetCount()>0 then
		if g:IsExists(c170012.filter,1,nil) then
			Duel.DiscardDeck(tp,3,REASON_EFFECT)
		end
		Duel.ShuffleDeck(tp)
	end
end