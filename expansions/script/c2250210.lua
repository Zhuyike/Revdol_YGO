--全糖珍奶大杯
function c2250210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xff05))
	e2:SetValue(c2250210.atkval)
	c:RegisterEffect(e2)   
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c2250210.target)
	e3:SetOperation(c2250210.operation)
	c:RegisterEffect(e3) 
end
function c2250210.filter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250210.atkval(e)
	return Duel.GetMatchingGroupCount(c2250210.filter,e:GetHandlerPlayer(),LOCATION_REMOVED,0,nil)*300
end
function c2250210.cfilter(c)
	return c:IsSetCard(0xff05)
end
function c2250210.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250210.cfilter,tp,LOCATION_REMOVED,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_REMOVED)
end
function c2250210.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2250210.cfilter,tp,LOCATION_REMOVED,0,1,1,nil,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end