--玉藻神社
function c11110021.initial_effect(c)
	c11110021.e=1
	c:EnableCounterPermit(0x10fd)
	c:SetCounterLimit(0x10fd,999)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c11110021.activate)
	c:RegisterEffect(e1)
	--Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11110021,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCost(c11110021.cost)
	e2:SetOperation(c11110021.operation)
	c:RegisterEffect(e2)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTarget(c11110021.reptg)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(c11110021.condition)
	e5:SetOperation(c11110021.acop)
	c:RegisterEffect(e5)
	--search
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(11110021,3))
	e6:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_FZONE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCost(c11110021.drcost)
	e6:SetTarget(c11110021.drtg)
	e6:SetOperation(c11110021.drop)
	c:RegisterEffect(e6)
end
function c11110021.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c11110021.filter_yizhen,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c11110021.filter_yizhen,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
		end
	end
end
function c11110021.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x10fd,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x10fd,3,REASON_COST)
end
function c11110021.filter_yizhen(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c11110021.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11110021.filter_yizhen,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SEARCH+CATEGORY_TOHAND,nil,0,tp,1)
end
function c11110021.acop(e,tp,eg,ep,ev,re,r,rp)
	local num=eg:FilterCount(c11110021.sdfilter,nil)
	e:GetHandler():AddCounter(0x10fd,num)
end
function c11110021.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11110021.sdfilter,1,nil)
end
function c11110021.sdfilter(c)
	return c:IsSetCard(0xff00) and c:IsType(TYPE_MONSTER)
end
function c11110021.filter(c)
	return c:IsSetCard(0xff00) and c:IsAbleToGraveAsCost() and c:IsType(TYPE_MONSTER)
end
function c11110021.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11110021.filter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringid(11110021,4)) then
		local g=Duel.SelectMatchingCard(tp,c11110021.filter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil)
		if Duel.SendtoGrave(g,REASON_COST)>0 then
			return true
		end
	else return false end
end
function c11110021.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
function c11110021.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(11110021,1))
	Duel.PayLPCost(tp,1000)
end
function c11110021.operation(e,tp,eg,ep,ev,re,r,rp)
	c11110021.e=c11110021.e+1
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c11110021.e)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11110021.posop(e,tp,eg,ep,ev,re,r,rp)
	c11110021.e=1
end