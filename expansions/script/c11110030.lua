--输了
function c11110030.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c11110030.target)
	e1:SetOperation(c11110030.activate)
	c:RegisterEffect(e1)  
	--cannot attack announce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c11110030.condition)
	e2:SetTarget(c11110030.antarget)
	c:RegisterEffect(e2)  
end
function c11110030.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3)  end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,tp,3)
end
function c11110030.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,3)
	Duel.SendtoGrave(g1,REASON_EFFECT)
end
function c11110030.filter1(c)
	return c:IsSetCard(0xff00) and c:IsPosition(POS_DEFENSE) and c:IsFaceup()
end
function c11110030.filter2(c)
	return c:IsLevelAbove(3)
end
function c11110030.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11110030.filter1,tp,LOCATION_MZONE,0,2,e:GetHandler())
end
function c11110030.antarget(e,c)
	return Duel.GetMatchingGroup(c11110030.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end