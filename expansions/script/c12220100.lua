--慈善赌王·祈蝶沐风
function c12220100.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetCondition(c12220100.condition)
	e1:SetOperation(c12220100.operation)
	c:RegisterEffect(e1)	
end
function c12220100.condition(e)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c12220100.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	if tc:IsType(TYPE_SPELL) then
		local tg=Duel.GetMatchingGroup(c12220100.filter,tp,LOCATION_MZONE,0,nil)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12220100,0))
			local target=Duel.SelectMatchingCard(tp,c12220100.filter,tp,LOCATION_MZONE,0,1,1,nil)
			local tcc=target:GetFirst()
			local act=tcc:GetAttack()
			local en=Effect.CreateEffect(e:GetHandler())
			en:SetType(EFFECT_TYPE_SINGLE)
			en:SetCode(EFFECT_UPDATE_ATTACK)
			en:SetReset(RESET_EVENT+RESETS_STANDARD)
			en:SetValue(act)
			tcc:RegisterEffect(en)
		end
	elseif tc:IsType(TYPE_TRAP) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.SSet(tp,tc)
	elseif tc:IsType(TYPE_MONSTER) then
		local act=tc:GetAttack()
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,act,REASON_EFFECT)
		end
	end
end
function c12220100.filter(c)
	return c:IsSetCard(0xff04) and c:IsFaceup()
end