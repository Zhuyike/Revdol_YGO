--演技大转盘
function c170027.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170027,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c170027.atkcon)
	e2:SetTarget(c170027.atktg)
	e2:SetOperation(c170027.atkop)
	c:RegisterEffect(e2)
end
--c170027.toss_coin=true
function c170027.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
end
function c170027.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,0,tp,1)
end
function c170027.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local a=Duel.GetAttacker()
	if not a:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local opt=Duel.AnnounceType(1-tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local sg=g:RandomSelect(1-tp,1)
	if sg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,sg)
		Duel.BreakEffect()
		Duel.ShuffleHand(tp)
		local tc=sg:GetFirst()
		if (opt==0 and not tc:IsType(TYPE_MONSTER)) or (opt==1 and not tc:IsType(TYPE_SPELL)) or (opt==2 and not tc:IsType(TYPE_TRAP)) then
			Duel.SendtoHand(a,nil,REASON_EFFECT)
		end
	end
end