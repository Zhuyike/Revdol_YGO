--喀秋莎
function c60620002.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c60620002.condition)
	e1:SetTarget(c60620002.target)
	e1:SetOperation(c60620002.activate)
	c:RegisterEffect(e1)
end
function c60620002.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return tp~=Duel.GetTurnPlayer() --and d and d:IsControler(tp)
end
function c60620002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c60620002.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tg=Duel.GetAttackTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e1:SetValue(c60620002.atlimit)
	e:GetHandler():RegisterEffect(e1)
end
function c60620002.atlimit(e,c)
	local tg=Duel.GetAttackTarget()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	return tg
end
