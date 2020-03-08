--窥屏意志·狂风道人
function c12220120.initial_effect(c)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12220120,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetTarget(c12220120.sptg)
	e3:SetOperation(c12220120.spop)
	c:RegisterEffect(e3)
	--hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_INITIAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(c12220120.op)
	c:RegisterEffect(e1)
end
function c12220120.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if tc:IsType(TYPE_MONSTER) then
		local lv=tc:GetLevel()
		if Duel.GetMatchingGroupCount(c12220120.thfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,nil,lv,e,tp)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=Duel.SelectMatchingCard(tp,c12220120.thfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,lv,e,tp)
			if tg:GetCount()>0 then
				Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
				local en=Effect.CreateEffect(e:GetHandler())
				en:SetType(EFFECT_TYPE_SINGLE)
				en:SetCode(EFFECT_UPDATE_ATTACK)
				en:SetReset(RESET_EVENT+RESETS_STANDARD)
				en:SetValue(300)
				tg:RegisterEffect(en)
			end
		end
	end
end
function c12220120.thfilter(c,level,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()<=level
end
function c12220120.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c12220120.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12220120.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c12220120.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
		end
	end
end
function c12220120.spfilter(c)
	return c:IsSetCard(0xff04) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsAbleToHand()
end