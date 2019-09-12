--初始之翼
function c92700320.initial_effect(c)

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c92700320.condition)
	e1:SetOperation(c92700320.operation)
	c:RegisterEffect(e1)
end
function c92700320.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function c92700320.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c92700320.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0  then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end

function c92700320.thfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToHand()
end
