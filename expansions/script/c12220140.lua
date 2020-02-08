--泪伤梦雅爱之瑰·灵生
function c12220140.initial_effect(c)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c12220140.remcon)
	e1:SetTarget(c12220140.remtg)
	e1:SetOperation(c12220140.remop)
	c:RegisterEffect(e1)
	--Damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1)
	e3:SetCost(c12220140.cost)
	e3:SetOperation(c12220140.damop)
	c:RegisterEffect(e3) 
end
function c12220140.filter(c)
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220140.remcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c12220140.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)>0
end
function c12220140.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c12220140.remop(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
   if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,1,nil)
		local tc=g:GetFirst()
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c12220140.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST+REASON_DISCARD)
end
function c12220140.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c12220140.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	if ct>0 then
		Duel.Damage(1-tp,ct*300,REASON_EFFECT)
	end
end