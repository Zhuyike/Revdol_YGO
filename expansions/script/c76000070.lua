--练习型李清歌
function c76000070.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,1,true,true)
	aux.AddContactFusionProcedure(c,nil,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)
	--SendtoGrave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76000070,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,76000070)
	e1:SetCost(c76000070.cost)
	e1:SetTarget(c76000070.target)
	e1:SetOperation(c76000070.operation)
	c:RegisterEffect(e1)  
end
function c76000070.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c76000070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField()  end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,300)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,300)
end
function c76000070.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
		if tc:IsLocation(LOCATION_GRAVE) then
			Duel.Recover(1-tp,300,REASON_EFFECT)
			Duel.Recover(tp,300,REASON_EFFECT)
		end
	end
end
