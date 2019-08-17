--伊贞机关
function c92700001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c92700001.activate)
	c:RegisterEffect(e1) 
	local e2=Effect.CreateEffect(c)
   -- e2:SetCategory
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCost(c92700001.cost)
	e2:SetOperation(c92700001.setop)
end
function c92700001.thfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToHand()
end
function c92700001.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c92700001.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(92700001,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c92700001.costfilter(c)
	return c:IsCode(99999999) and c:IsAbleToGraveAsCost()
end
function c92700001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700001.costfilter,tp,LOCATION_HAND,0,1,c) end
	local g=Duel.IsExistingMatchingCard(c92700001.costfilter,tp,LOCATION_HAND,0,1,c)
	Duel.DiscardHand(tp,c92700001.costfilter,1,1,REASON_COST+REASON_DISCARD)
end

function c92700001.setfilter(c)
	return c:IsSetCard(0xffff) and c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsSSetable()
end
function c92700001.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c92700001.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,g)
	end
end