--芙蕾
function c2250090.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250090)
	e1:SetCondition(c2250090.spcon)
	c:RegisterEffect(e1)	
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,2250091)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c2250090.atkcost)
	e2:SetOperation(c2250090.atkop)
	c:RegisterEffect(e2)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_REMOVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,2250092)
	e3:SetTarget(c2250090.target)
	e3:SetOperation(c2250090.operation)
	c:RegisterEffect(e3)  
end
function c2250090.filter(c)
	return c:IsFacedown()  
end
function c2250090.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c2250090.filter,tp,0,LOCATION_ONFIELD,1,nil)
end

function c2250090.atkcfilter(c)
	return c:IsSetCard(0xff05) and c:IsLevelBelow(6) and c:IsAbleToRemoveAsCost()
end
function c2250090.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(2250090)==0
		and Duel.IsExistingMatchingCard(c2250090.atkcfilter,tp,LOCATION_HAND,0,1,nil) end
	c:RegisterFlagEffect(2250090,RESET_CHAIN,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c2250090.atkcfilter,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabel(rg:GetFirst():GetAttack())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c2250090.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c2250090.bkfilter(c)
	return c:IsSetCard(0xff05) and c:IsAbleToGrave()
end
function c2250090.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c2250090.bkfilter(chkc) end
	if chk==0 then return Duel.GetMatchingGroupCount(c2250090.bkfilter,tp,LOCATION_REMOVED,0,3,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c2250090.bkfilter,tp,LOCATION_REMOVED,0,3,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),tp,LOCATION_REMOVED)
end
function c2250090.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoGrave(tg,nil,0,REASON_EFFECT) 
end