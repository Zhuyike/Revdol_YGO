--一军
function c60602010.initial_effect(c)
		--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c60602010.condition)
	e1:SetTarget(c60602010.target)
	e1:SetOperation(c60602010.operation)
	c:RegisterEffect(e1)
end
function c60602010.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c60602010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanChangePosition() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,tg,1,0,0)
end
function c60602010.operation(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)~=0 then
		Duel.NegateAttack()
	end
end