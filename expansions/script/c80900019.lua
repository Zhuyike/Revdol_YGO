--泳装型搬砖小妹
function c80900019.initial_effect(c)
	--cannot des
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(c80900019.cfilter))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--self des
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80900019,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c80900019.tgcon2)
	e2:SetTarget(c80900019.target)
	e2:SetOperation(c80900019.activate)
	c:RegisterEffect(e2)
end
function c80900019.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c80900019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==tp and c80900019.filter(chkc)end
	if chk==0 then return Duel.IsExistingTarget(c80900019.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c80900019.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c80900019.filter(c)
	return c:IsSetCard(0xfff8) and c:IsRace(RACE_CREATORGOD) and c:IsAbleToHand()
end
function c80900019.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xfff8) and c:IsRace(RACE_CREATORGOD) and c:IsAbleToHand()
end 
function c80900019.tgcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY)
end