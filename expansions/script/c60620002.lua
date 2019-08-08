--喀秋莎
function c60620002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c60620002.condition)
	e1:SetOperation(c60620002.activate)
	c:RegisterEffect(e1)
end
function c60620002.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d then
		return d:IsControler(tp)
	else
		return false
	end
end
function c60620002.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tg=Duel.GetAttackTarget()
	local e1=Effect.CreateEffect(tg)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e1:SetValue(aux.imval1)
	tg:RegisterEffect(e1)
end