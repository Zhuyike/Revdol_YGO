--Swan型李清歌
function c76000010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,2,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)
	--immune effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c76000010.efilter)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76000010,0))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c76000010.target)
	e2:SetOperation(c76000010.operation)
	c:RegisterEffect(e2)
end
function c76000010.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP) 
end
function c76000010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField()  end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and c:GetFlagEffect(76000010)==0 end
	c:RegisterFlagEffect(76000010,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c76000010.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
		if tc:IsLocation(LOCATION_GRAVE) then Duel.Recover(tp,500,REASON_EFFECT) end
	end
end
