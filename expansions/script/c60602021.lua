--无奈Xx(秃头)
function c60602021.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c60602021.target)
	e1:SetOperation(c60602021.operation)
	c:RegisterEffect(e1)
end
function c60602021.filter(c)
	return c:IsType(TYPE_TOKEN) and c:IsCode(60602022)
end
function c60602021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c60602021.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,60602022,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_LIGHT) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,60602021+i)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
	Duel.SelectTarget(tp,c60602021.filter,tp,LOCATION_MZONE,0,1,1,nil,0x10fe,1)
	 local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x10fe,1)
	end
end
