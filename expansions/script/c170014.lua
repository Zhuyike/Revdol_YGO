--蓝色石鱿鱼
function c170014.initial_effect(c)
	-- special summon from grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170014,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,170014)
	e1:SetCondition(c170014.e1con)
	e1:SetOperation(c170014.e1op)
	c:RegisterEffect(e1)
	-- special summon 蓝色石鱿鱼
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170014,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c170014.e2con)
	e2:SetTarget(c170014.e2tg)
	e2:SetOperation(c170014.e2op)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	-- 判断是否为当回合送墓
	if not c170014.global_check then
		c170014.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c170014.ge1op)
		Duel.RegisterEffect(ge1,0)
	end
end
function c170014.e2op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c170014.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		Duel.ShuffleDeck(tp)
	end
end
function c170014.filter2(c,e,tp)
	return c:IsCode(170014) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c170014.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c170014.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c170014.e2con(e,tp,eg,ep,ev,re,r,rp)
	return re~=e:GetLabelObject()
end
function c170014.ge1op(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsLocation(LOCATION_GRAVE) then
			tc:RegisterFlagEffect(170014,RESET_EVENT+0x1f20000+RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end
function c170014.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetFlagEffect(170014)~=0 and c:IsLocation(LOCATION_GRAVE) and (not c:IsCode(170014))
end
function c170014.e1con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c170014.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) and c:IsAbleToGrave()
end
function c170014.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsLocation(LOCATION_MZONE) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		if Duel.IsExistingMatchingCard(c170014.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) then
			local g=Duel.SelectTarget(tp,c170014.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
			if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
				local gc=g:GetFirst()
				local e1=Effect.CreateEffect(gc)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
				e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
				e1:SetValue(LOCATION_REMOVED)
				gc:RegisterEffect(e1,true)
			end
		end
	end
end