--MO妮子酱
function c170016.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170016,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c170016.e1con)
	e1:SetTarget(c170016.e1tg)
	e1:SetOperation(c170016.e1op)
	c:RegisterEffect(e1)
	-- atk&def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c170016.e2con)
	e2:SetTarget(c170016.e2tg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetTarget(c170016.e2tg)
	e3:SetValue(300)
	c:RegisterEffect(e3)
	-- cannot be attacked
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c170016.e4con)
	e4:SetTarget(c170016.e4tg)
	e4:SetValue(aux.imval1)
	c:RegisterEffect(e4)
end
function c170016.e4con(e)
	return Duel.IsExistingMatchingCard(c170016.e1filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,3,nil)
end
function c170016.e4tg(e,c)
	return c:IsSetCard(0xfff0)
end
function c170016.e2tg(e,c)
	return c:IsSetCard(0xfff0)
end
function c170016.e2tg(e,c)
	return c:IsSetCard(0xfff0)
end
function c170016.e2con(e)
	return Duel.IsExistingMatchingCard(c170016.e1filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,2,nil)
end
function c170016.e1filter(c)
	return c:IsFaceup() and c:IsSetCard(0xfff0) and (not c:IsCode(170016))
end
function c170016.e1con(e)
	return Duel.IsExistingMatchingCard(c170016.e1filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c170016.e1filter2(c)
	return c:IsCode(170025) and c:IsAbleToHand()
end
function c170016.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170016.e1filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c170016.e1op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c170016.e1filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
	end
end