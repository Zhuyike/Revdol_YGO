--狂风道人
function c60602013.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c60602013.thtg)
	e1:SetOperation(c60602013.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--SearchCard
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetTarget(c60602013.fothtg)
	e3:SetOperation(c60602013.fothop)
	c:RegisterEffect(e3)
end
function c60602013.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c60602013.fothfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsLevelBelow(8) and c:IsAbleToHand()
end
function c60602013.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c60602013.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c60602013.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c60602013.thop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c60602013.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0)
	Duel.Destroy(sg,REASON_EFFECT)
end
function c60602013.fothtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60602013.fothfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60602013.fothop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60602013.fothfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end