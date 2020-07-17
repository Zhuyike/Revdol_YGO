--伊贞型墨汐
function c2250300.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,3,false,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_EFFECT)  
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c2250300.rmtg)
	e1:SetOperation(c2250300.rmop)
	c:RegisterEffect(e1) 
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c2250300.cost)
	e2:SetCondition(c2250300.negcon)
	e2:SetTarget(c2250300.negtg)
	e2:SetOperation(c2250300.negop)
	c:RegisterEffect(e2)  
end
function c2250300.rmfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c2250300.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250300.rmfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)>0 end
	local g=Duel.GetMatchingGroup(c2250300.rmfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c2250300.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c2250300.rmfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
	if g:GetCount()>0 and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
		if  c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(g:GetCount()*400)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
			if g:GetCount()>4 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e:GetHandler():RegisterEffect(e1)
			end
		end
	end
end
function c2250300.costfilter(c)
	return c:IsSetCard(0xff05) and c:IsAbleToRemoveAsCost()
end
function c2250300.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250300.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250300.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250300.negcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c2250300.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c2250300.negop(e,tp,eg,ep,ev,re,r,rp)
	 Duel.NegateActivation(ev)
end