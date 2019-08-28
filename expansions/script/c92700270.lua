--歌姬占卜
function c92700270.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c92700270.operation)
	c:RegisterEffect(e1)	
end
function c92700270.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_SPELL) then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c92700270.setg1)
	e1:SetOperation(c92700270.seop1)
	e:GetHandler():RegisterEffect(e1)
	elseif tc:IsType(TYPE_TRAP) then
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c92700270.setg2)
	e2:SetOperation(c92700270.seop2)
	e:GetHandler():RegisterEffect(e2) 
	elseif tc:IsType(TYPE_MONSTER) then
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetTarget(c92700270.setg3)
	e3:SetOperation(c92700270.seop3)
	e:GetHandler():RegisterEffect(e3)	
	end
end
function c92700270.filter1(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c92700270.setg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700270.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92700270.seop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92700270.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c92700270.filter2(c)
	return c:IsSetCard(0xfff7) and c:IsAbleToHand()
end
function c92700270.setg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700270.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92700270.seop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92700270.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c92700270.filter3(c)
	return c:IsSetCard(0xffff) and c:IsAbleToHand()
end
function c92700270.setg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700270.filter3,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92700270.seop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92700270.filter3,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end