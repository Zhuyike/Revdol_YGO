--模式转换
function c170026.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c170026.condition)
	e1:SetTarget(c170026.target)
	e1:SetOperation(c170026.activate)
	c:RegisterEffect(e1)
end
function c170026.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c170026.filter(c)
	return c:IsFaceup()
end
function c170026.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170026.filter,tp,LOCATION_MZONE,0,1,nil) end
	local op=0
	if Duel.IsExistingMatchingCard(c170026.filter,tp,LOCATION_MZONE,0,1,nil) then
		op=Duel.SelectOption(tp,aux.Stringid(170026,1),aux.Stringid(170026,2))
	end
	e:SetLabel(op)
end
function c170026.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c170026.filter,tp,LOCATION_MZONE,0,nil)
	if e:GetLabel()==0 then
		-- atk up
		local gc=sg:GetFirst()
		while gc do
			if gc:IsFaceup() then
				local e1=Effect.CreateEffect(gc)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UPDATE_ATTACK)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				e1:SetValue(400)
				gc:RegisterEffect(e1)
				c=e:GetHandler()
			end
			gc=sg:GetNext()
		end
	else
		--def up
		local gc=sg:GetFirst()
		while gc do
			if gc:IsFaceup() then
				local e1=Effect.CreateEffect(gc)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UPDATE_DEFENSE)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				e1:SetValue(800)
				gc:RegisterEffect(e1)
				c=e:GetHandler()
			end
			gc=sg:GetNext()
		end
	end
end