--蓝宸
function c2250030.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1,2250030)
	e1:SetCost(c2250030.thcost)
	e1:SetTarget(c2250030.thtg)
	e1:SetOperation(c2250030.thop)
	c:RegisterEffect(e1)  
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,2250031)
	e2:SetCost(c2250030.cost)
	e2:SetTarget(c2250030.sptg)
	e2:SetOperation(c2250030.spop)
	c:RegisterEffect(e2)  
	--change pos 
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2250030,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,2250032)
	e3:SetTarget(c2250030.postg)
	e3:SetOperation(c2250030.posop)
	c:RegisterEffect(e3)  
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_REMOVE)
	e4:SetCountLimit(1,2250033)
	e4:SetTarget(c2250030.destg)
	e4:SetOperation(c2250030.desop)
	c:RegisterEffect(e4) 
end
function c2250030.cfilter(c)
	return c:IsCode(2250010) and c:IsAbleToRemoveAsCost()
end
function c2250030.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250030.cfilter,tp,LOCATION_GRAVE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250030.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250030.thfilter(c,tp)
	return c:IsCode(2250030)  and c:IsAbleToHand()
end
function c2250030.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250030.thfilter,tp,LOCATION_DECK,0,1,nil,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c2250030.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c2250030.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.RegisterFlagEffect(tp,2250030,RESET_PHASE+PHASE_END,0,1)
end
function c2250030.costfilter(c)
	return c:IsSetCard(0xff05) and c:IsAbleToRemoveAsCost()
end
function c2250030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250030.costfilter,tp,LOCATION_MZONE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250030.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2250030.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c2250030.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c2250030.posfilter(c)
	return c:IsFacedown()  and c:IsDefensePos()
end
function c2250030.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c2250030.posfilter,tp,0,LOCATION_MZONE,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function c2250030.posop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c2250030.posfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local pos=Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEUP_DEFENSE)
		Duel.ChangePosition(tc,pos)
	end
end
function c2250030.desfilter(c)
	return c:IsFacedown() 
end
function c2250030.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c2250030.desfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c2250030.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c2250030.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c2250030.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
