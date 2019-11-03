--空空的酱油瓶
function c10010200.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10010200,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,10010200)
	e1:SetCost(c10010200.thcost)
	e1:SetTarget(c10010200.thtg)
	e1:SetOperation(c10010200.thop)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10010200,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,10010201)
	e2:SetCost(c10010200.spcost)
	e2:SetTarget(c10010200.sptg)
	e2:SetOperation(c10010200.spop)
	c:RegisterEffect(e2)
end
function c10010200.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c10010200.filter_utahime,tp,LOCATION_EXTRA,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.SelectMatchingCard(tp,c10010200.filter_utahime,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			if Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetRange(LOCATION_MZONE)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetCondition(c10010200.tdcon)
				e1:SetOperation(c10010200.tdop)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
				e1:SetCountLimit(1)
				tc:RegisterEffect(e1)
				Duel.SpecialSummonComplete()
			end
		end
	end
end
function c10010200.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c10010200.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
end
function c10010200.filter_utahime(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_CREATORGOD) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c10010200.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10010200.filter_utahime,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c10010200.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0 end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c10010200.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c10010200.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c10010200.filter_dd(c,e,tp)
	return c:IsSetCard(0xff09) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10010200.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_MONSTER) then
		if Duel.Draw(tp,1,REASON_EFFECT)>0 then
			if Duel.IsExistingMatchingCard(c10010200.filter_dd,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
				local op=Duel.SelectOption(tp,aux.Stringid(10010200,2),aux.Stringid(10010200,3))
				if op==1 then return end
				local tg=Duel.SelectMatchingCard(tp,c10010200.filter_dd,tp,LOCATION_HAND,0,1,1,nil,e,tp)
				Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	else
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end