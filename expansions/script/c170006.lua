--某A君
function c170006.initial_effect(c)
	--summon effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170006,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_DEFCHANGE)
	e2:SetTarget(c170006.e1tg)
	e2:SetOperation(c170006.e1op)
	c:RegisterEffect(e2)
	--spsummon effect
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c170006.filter(c)
	return c:IsFaceup()
end
function c170006.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	--Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,tp,LOCATION_MZONE)
end
function c170006.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(c170006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c170006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
		if tc:GetCount()>0 then
			local code=tc:GetFirst():GetOriginalCode()
			local cid=c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)
			Duel.BreakEffect()
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EFFECT_SET_DEFENSE)
			e1:SetValue(500)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1)
		end
	end
end