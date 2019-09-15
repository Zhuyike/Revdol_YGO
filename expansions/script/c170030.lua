--歌姬 伊莎贝拉•霍利
function c170030.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,3,false,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170030,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c170030.spcon)
	e1:SetTarget(c170030.sptg)
	e1:SetOperation(c170030.spop)
	c:RegisterEffect(e1)
	--yizhen tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170030,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170030.thcon)
	e2:SetCost(c170030.thco)
	e2:SetOperation(c170030.thop)
	c:RegisterEffect(e2)
end
function c170030.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=2 then return end
	Duel.SendtoHand(tg,tp,REASON_EFFECT)
end
function c170030.thco(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170030.filter_yizhen,tp,LOCATION_GRAVE,0,3,nil) and Duel.IsExistingMatchingCard(c170030.filter_yizhen2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170030.filter_yizhen2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectTarget(tp,c170030.filter_yizhen,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg,2,tp,LOCATION_GRAVE)
end
function c170030.filter_yizhen(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c170030.filter_yizhen2(c)
	return c:IsCode(99999999) and c:IsAbleToRemoveAsCost()
end
function c170030.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c170030.filter_yizhen,tp,LOCATION_GRAVE,0,3,nil) and Duel.IsExistingMatchingCard(c170030.filter_yizhen2,tp,LOCATION_GRAVE,0,1,nil)
end
function c170030.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c170030.spfilter(c,e,tp)
	return c:IsLevelBelow(8) and c:IsSetCard(0xfff0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) 
end
function c170030.spfilter2(c,e,tp,lv)
	return c:IsLevelBelow(8-lv) and c:IsSetCard(0xfff0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c170030.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c170030.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c170030.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(c170030.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c170030.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local lv=g:GetFirst():GetLevel()
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then
		else
			if lv<8 and Duel.IsExistingMatchingCard(c170030.spfilter2,tp,LOCATION_DECK,0,1,g,e,tp,lv) then
				local g2=Duel.SelectMatchingCard(tp,c170030.spfilter2,tp,LOCATION_DECK,0,1,1,g,e,tp,lv)
				g:Merge(g2)
			end
			if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
				local tc=g:GetFirst()
				while tc do
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetCategory(CATEGORY_TOHAND)
					e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
					e1:SetCode(EVENT_PHASE+PHASE_END)
					e1:SetRange(LOCATION_MZONE)
					e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
					e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
					e1:SetOperation(c170030.tdop)
					e1:SetCountLimit(1)
					tc:RegisterEffect(e1)
					tc=g:GetNext()
				end
			end
		end
	end
end
function c170030.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoHand(c,tp,REASON_EFFECT)
end