--北城
function c2250070.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250070)
	e1:SetCost(c2250070.spcost)
	e1:SetTarget(c2250070.sptg)
	e1:SetOperation(c2250070.spop)
	c:RegisterEffect(e1)	
	--protect battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14577226,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,2250071)
	e2:SetCost(c2250070.indcost)
	e2:SetCondition(c2250070.indcon)
	e2:SetOperation(c2250070.indop)
	c:RegisterEffect(e2)  
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2250070,0))
	e3:SetCategory(CATEGORY_TOGRAVE+CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e3:SetCountLimit(1,2250070+EFFECT_COUNT_CODE_DUEL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c2250070.con)
	e3:SetTarget(c2250070.tg)
	e3:SetOperation(c2250070.op)
	c:RegisterEffect(e3)
end
function c2250070.cfilter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and 
	c:IsAbleToRemoveAsCost()
end
function c2250070.mzfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5
end
function c2250070.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local rg=Duel.GetMatchingGroup(c2250070.cfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	if chk==0 then return ft>-2 and rg:GetCount()>1 and (ft>0 or rg:IsExists(c2250070.mzfilter,ct,nil,tp)) end
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=rg:Select(tp,2,2,nil)
	elseif ft==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=rg:FilterSelect(tp,c2250070.mzfilter,1,1,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g2=rg:Select(tp,1,1,g:GetFirst())
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g=rg:FilterSelect(tp,c2250070.mzfilter,2,2,nil,tp)
	end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250070.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c2250070.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	 Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c2250070.indcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
	and Duel.GetTurnPlayer()~=tp
end
function c2250070.indcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250070.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250070.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250070.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup()  then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTarget(c2250070.ptfilter)
		e1:SetValue(1)
		Duel.RegisterEffect(e1,tp)
	end
end
function c2250070.ptfilter(e,c)
	return c:IsControler(tp)
end
function c2250070.filter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER)
end
function c2250070.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c2250070.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250070.filter,tp,LOCATION_HAND,0,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c2250070.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c2250070.filter,tp,LOCATION_HAND,0,1,63,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(g:GetCount()*500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end