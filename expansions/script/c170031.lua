--噩梦 伊莎贝拉•霍利
function c170031.initial_effect(c)
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
	e2:SetCondition(c170031.spcon)
	e2:SetOperation(c170031.spop)
	c:RegisterEffect(e2)	
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(170031,3))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,170031)
	e3:SetTarget(c170031.destg)
	e3:SetOperation(c170031.desop)
	c:RegisterEffect(e3)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(170031,2))
	e7:SetCategory(CATEGORY_COUNTER)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetTarget(c170031.e7tg)
	e7:SetOperation(c170031.e7op)
	c:RegisterEffect(e7)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(170031,0))
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetTarget(c170031.postg)
	e4:SetOperation(c170031.posop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetDescription(aux.Stringid(170031,1))
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetTarget(c170031.rettg)
	e5:SetOperation(c170031.retop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(170031,1))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_REMOVE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetTarget(c170031.rettg)
	e6:SetOperation(c170031.retop)
	c:RegisterEffect(e6)
end
function c170031.e7filter(c)
	return c:GetCounter(0x10ff)~=0
end
function c170031.e7tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170031.e7filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c170031.e7op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c170031.e7filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	while tc do
		local oc=tc:GetCounter(0x10ff)
		tc:RemoveCounter(tp,0x10ff,oc,REASON_EFFECT)
		tc:AddCounter(0x10fe,oc)
		tc=sg:GetNext()
	end
end
function c170031.spfilter(c,tp,g,sc)
	return c:IsAbleToGraveAsCost()  and Duel.GetLocationCountFromEx(tp)>0
end
function c170031.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c170031.spfilter,tp,LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	return  Duel.IsCanRemoveCounter(tp,1,0,0x10fe,6,REASON_COST) and g:CheckWithSumGreater(Card.GetLevel,6)
end
function c170031.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c170031.spfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:SelectWithSumGreater(tp,Card.GetLevel,6)
	Duel.RemoveCounter(tp,1,0,0x10fe,6,REASON_COST)
	Duel.SendtoGrave(sg,REASON_COST+REASON_DISCARD)
end
function c170031.desfilter(c)
	return c:IsFacedown()
end
function c170031.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c170031.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c170031.desfilter,tp,0,LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function c170031.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
function c170031.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c170031.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end
function c170031.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCanTurnSet,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsCanTurnSet,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c170031.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsCanTurnSet,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end