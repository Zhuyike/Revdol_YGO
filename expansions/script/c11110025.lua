--玉藻三连
function c11110025.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c11110025.target)
	e1:SetOperation(c11110025.activate)
	c:RegisterEffect(e1)	  
end
function c11110025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3)  end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,tp,3)
end
function c11110025.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,3)
	Duel.SendtoGrave(g1,REASON_EFFECT)	
	local tc=g1:GetFirst()
	while tc do
		if   tc:IsType(TYPE_MONSTER) then
		Duel.Damage(1-tp,500,REASON_EFFECT)
		end
		if   tc:IsType(TYPE_SPELL+TYPE_TRAP) then
		Duel.Damage(tp,500,REASON_EFFECT)
		end
		tc=g1:GetNext()
	end
end