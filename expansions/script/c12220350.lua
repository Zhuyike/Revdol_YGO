--傻白甜·妮姆
function c12220350.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c12220350.target)
	e1:SetOperation(c12220350.activate)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c12220350.atkvalue)
	c:RegisterEffect(e2)
end
function c12220350.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c12220350.activate(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
   if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,1,nil)
		local tc=g:GetFirst()
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c12220350.rmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c12220350.atkvalue(e,c)
	return Duel.GetMatchingGroupCount(c12220350.rmfilter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*200
end