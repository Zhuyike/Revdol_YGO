--噩梦 卡缇娅·乌拉诺娃
function c60602001.initial_effect(c)
	c:EnableReviveLimit()   
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c60602001.spcon)
	e2:SetOperation(c60602001.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c60602001.atkcon)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK))
	e3:SetValue(1500)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(-1000)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetTarget(c60602001.rettg)
	e5:SetOperation(c60602001.retop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_REMOVE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetTarget(c60602001.rettg)
	e6:SetOperation(c60602001.retop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_EXTRA_ATTACK)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_COUNTER)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_SPSUMMON_SUCCESS)
	e8:SetTarget(c60602001.cttg)
	e8:SetOperation(c60602001.ctop)
	c:RegisterEffect(e8)
end
function c60602001.atkcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c60602001.spfilter(c,tp,g,sc)
	return c:IsAbleToGraveAsCost()  and Duel.GetLocationCountFromEx(tp)>0
end
function c60602001.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c60602001.spfilter,tp,LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	return  Duel.IsCanRemoveCounter(tp,1,0,0x10fe,6,REASON_COST) and g:CheckWithSumGreater(Card.GetLevel,6)
end
function c60602001.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c60602001.spfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:SelectWithSumGreater(tp,Card.GetLevel,6)
	Duel.RemoveCounter(tp,1,0,0x10fe,6,REASON_COST)
	Duel.SendtoGrave(sg,REASON_COST+REASON_DISCARD)
end
function c60602001.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c60602001.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end
function c60602001.ctfilter(c)
	return c:GetCounter(0x10ff)~=0
end
function c60602001.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60602001.ctfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c60602001.ctop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c60602001.ctfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	while tc do
		local oc=tc:GetCounter(0x10ff)
		tc:RemoveCounter(tp,0x10ff,oc,REASON_EFFECT)
		tc:AddCounter(0x10fe,oc)
		tc=sg:GetNext()
	end
end