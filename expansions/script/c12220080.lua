--夜魇·千夜
function c12220080.initial_effect(c)
	--activate limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c12220080.condition)
	e3:SetValue(c12220080.aclimit1)
	c:RegisterEffect(e3)

	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c12220080.destg)
	e1:SetOperation(c12220080.desop)
	c:RegisterEffect(e1)
end
function c12220080.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(c12220080.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c12220080.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c12220080.filter(c,tp)
	return c:GetAttack() < Duel.GetLP(tp)
end
function c12220080.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local lp=tc:GetAttack()
		if Duel.Damage(tp,lp,REASON_EFFECT)>0 then
			local tg=Duel.GetMatchingGroup(c12220080.filter_lp,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),lp)
			local tcc=tg:GetFirst()
			while(tcc)do
				Duel.Destroy(tcc,REASON_EFFECT)
				tcc=tg:GetNext()
			end
		end
	end
end
function c12220080.filter_lp(c,lp)
	return c:GetAttack()<=lp
end
function c12220080.condition(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c12220080.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end