--三岁嗔顽
function c60602015.initial_effect(c)
	--change pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60602015,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c60602015.poscon2)
	e1:SetTarget(c60602015.postg2)
	e1:SetOperation(c60602015.posop2)
	c:RegisterEffect(e1)
	--add flower
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60602015,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(aux.bfgcost)
	e2:SetCondition(c60602015.poscon1)
	e2:SetOperation(c60602015.activate)
	c:RegisterEffect(e2)
end
function c60602015.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local gc=g:GetFirst()
	gc:AddCounter(0x10ff,1)
end
function c60602015.poscon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c60602015.poscon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c60602015.postg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=e:GetHandler():GetReasonCard()
	if chk==0 then return rc:IsCanTurnSet() end
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,rc,1,0,0)
end
function c60602015.posop2(e,tp,eg,ep,ev,re,r,rp)
	local rc=Duel.GetFirstTarget()
	if rc:IsFaceup() and rc:IsRelateToEffect(e) then
		Duel.ChangePosition(rc,POS_FACEDOWN_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e1)
	end
end