--咸鸭掌
function c60620006.initial_effect(c)
	--get control
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c60620006.target2)
	e2:SetOperation(c60620006.activate2)
	c:RegisterEffect(e2)
end
function c60620006.activate2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c60620006.filter3,nil,e,tp)
	if g:GetCount()>0 then
		Duel.GetControl(g,tp)
		local gc=g:GetFirst()
		while gc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			gc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			gc:RegisterEffect(e2)
			gc=g:GetNext()
		end
	end
end
function c60620006.filter3(c,e,tp)
	return c:IsFaceup() and c:GetSummonPlayer()~=tp and c:IsRace(RACE_CREATORGOD) and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE) and c:IsAbleToChangeControler()
end
function c60620006.filter2(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_CREATORGOD) and c:GetSummonPlayer()~=tp and c:IsAbleToChangeControler()
end
function c60620006.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c60620006.filter2,1,nil,tp) end
	local g=eg:Filter(c60620006.filter2,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end