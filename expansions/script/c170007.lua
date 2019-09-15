--柠糸
function c170007.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c170007.e1tg)
	e1:SetValue(300)
	c:RegisterEffect(e1)
	--def up
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--attack negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(170007,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c170007.e3con)
	e3:SetCost(c170007.e3co)
	e3:SetOperation(c170007.e3op)
	c:RegisterEffect(e3)
end
function c170007.e1tg(e,c)
	return c:IsSetCard(0xfff0)
end
function c170007.e3con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp
end
function c170007.e3co(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)  end
	Duel.PayLPCost(tp,1000)
end
function c170007.e3op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end