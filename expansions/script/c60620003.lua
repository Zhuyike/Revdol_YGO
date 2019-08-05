--立场翻转
function c60620003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c60620003.condition)
	e1:SetTarget(c60620003.target)
	e1:SetOperation(c60620003.activate)
	c:RegisterEffect(e1)
end
function c60620003.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() 
end
function c60620003.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c60620003.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg and  c60620003.filter(chkc) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	local g=Duel.SelectTarget(tp,c60620003.filter,tp,0,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetTargetCard(tg)
end
function c60620003.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end