--墨得公平
function c2250240.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy drawn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCondition(c2250240.ddcon)
	e2:SetTarget(c2250240.ddtg)
	e2:SetOperation(c2250240.ddop)
	c:RegisterEffect(e2)	
end
function c2250240.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c2250240.ddfilter(c,tp)
	return c:IsControler(1-tp) and c:IsPreviousLocation(LOCATION_DECK)
end
function c2250240.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c2250240.ddfilter,nil,tp)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2250240.ddop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c2250240.ddfilter,nil,tp)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
	Duel.ConfirmCards(1-tp,tc)
	if   tc:IsType(TYPE_MONSTER) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	elseif tc:IsType(TYPE_SPELL+TYPE_TRAP) then
		Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
		end
	end
end