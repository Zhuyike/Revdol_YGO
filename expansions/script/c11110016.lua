--阿笋
function c11110016.initial_effect(c)
	--indes1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c11110016.cona)
	e1:SetTarget(c11110016.targeta)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c11110016.poscon)
	e2:SetOperation(c11110016.posop)
	c:RegisterEffect(e2)
	--discard deck
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetDescription(aux.Stringid(11110016,1))
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c11110016.discon)
	e3:SetTarget(c11110016.distg)
	e3:SetOperation(c11110016.disop)
	c:RegisterEffect(e3)
end
function c11110016.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c11110016.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c11110016.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end
function c11110016.filter_xintu(c)
	return c:IsSetCard(0xff00)
end
function c11110016.filter(c)
	local g=c:GetAttackedGroup()
	return g:IsExists(c11110016.filter_xintu,1,nil) and c:IsCanChangePosition()
end
function c11110016.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11110016.filter,tp,0,LOCATION_MZONE,1,nil) and e:GetHandler():IsFaceup()
end
function c11110016.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c11110016.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 and e:GetHandler():IsFaceup() then
		local tc=g:GetFirst()
		while tc do
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		end
	end
end
function c11110016.cona(e)
	return e:GetHandler():IsFaceup()
end
function c11110016.targeta(e,c)
	return c:IsSetCard(0xff00)
end