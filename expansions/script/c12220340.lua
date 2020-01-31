--图中灵·白图策
function c12220340.initial_effect(c)
	--des
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c12220340.atkcon)
	e1:SetTarget(c12220340.atktg)
	e1:SetOperation(c12220340.atkop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)	
end

function c12220340.atkfilter(c,e,tp)
	return  c:IsPosition(POS_FACEUP) and (not e or c:IsRelateToEffect(e)) and not c:IsCode(12220340)
end
function c12220340.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c12220340.atkfilter,1,nil,nil)
end
function c12220340.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end
function c12220340.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c12220340.atkfilter,nil,e)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
		if tc:IsAttackBelow(2000) then dg:AddCard(tc) end
		tc=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT,LOCATION_REMOVED)
end
