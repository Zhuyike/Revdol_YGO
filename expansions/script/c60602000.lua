--伊贞 卡缇娅·乌拉诺娃
function c60602000.initial_effect(c)
--
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
	e2:SetCondition(c60602000.spcon)
	e2:SetOperation(c60602000.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c60602000.dencon)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT))
	e3:SetValue(1000)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetCondition(c60602000.con)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetTarget(c60602000.rettg)
	e5:SetOperation(c60602000.retop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_REMOVE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetTarget(c60602000.rettg)
	e6:SetOperation(c60602000.retop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetCountLimit(1)
	e7:SetTarget(c60602000.distg)
	e7:SetOperation(c60602000.disop)
	c:RegisterEffect(e7)
end
function c60602000.cfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5
end
function c60602000.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE)  end
	if chk==0 then return Duel.IsExistingTarget(c60602000.cfilter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(60602000,2))
	local g=Duel.SelectTarget(tp,c60602000.cfilter,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	g:GetFirst():RegisterFlagEffect(c60602000,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1,cid)
end
function c60602000.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	tc:RegisterEffect(e2)
end
function c60602000.dencon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c60602000.con(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c60602000.spfilter(c)
	return c:IsAbleToGraveAsCost() 
end
function c60602000.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c60602000.spfilter,tp,LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	return  Duel.IsCanRemoveCounter(tp,1,0,0x10ff,6,REASON_COST) and g:CheckWithSumGreater(Card.GetLevel,6)
end
function c60602000.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c60602000.spfilter,c:GetControler(),LOCATION_MZONE,0,nil)
	if not c:IsAbleToGraveAsCost()  then
		g:RemoveCard(c)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg=g:SelectWithSumGreater(tp,Card.GetLevel,6)
	Duel.RemoveCounter(tp,1,0,0x10ff,6,REASON_COST)
	Duel.SendtoGrave(sg,REASON_COST+REASON_DISCARD)
end
function c60602000.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c60602000.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end