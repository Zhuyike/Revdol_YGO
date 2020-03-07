--呜呼！吾亡矣！
function c12220200.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c12220200.condition)
	e1:SetOperation(c12220200.operation)
	c:RegisterEffect(e1)
end
function c12220200.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c12220200.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	Duel.GetControl(tg,tp)
end
