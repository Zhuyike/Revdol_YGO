--汐汐的power！
function c2250200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c2250200.condition)
	e1:SetTarget(c2250200.target)
	e1:SetOperation(c2250200.activate)
	c:RegisterEffect(e1)	
end
function c2250200.condition(e,tp,eg,ep,ev,re,r,rp)
	return  tp~=Duel.GetTurnPlayer()
end
function c2250200.filter(c)
	return c:IsSetCard(0xff05)  and c:IsAbleToRemove()
end
function c2250200.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c2250200.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local td=Duel.GetAttackTarget()
	if tc:GetLevel()>td:GetLevel() then
		if e:GetHandler():IsRelateToEffect(e) and Duel.NegateAttack() then
			Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)  
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local g=Duel.SelectMatchingCard(p,c2250200.filter,p,LOCATION_DECK,0,1,1,nil)
			local tg=g:GetFirst()
			if tg then Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
			end
		end
	end
end
