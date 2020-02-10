--邪王真鸟·子鹓
function c12220070.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetOperation(c12220070.op1)
	c:RegisterEffect(e1)	  
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c12220070.target)
	e2:SetOperation(c12220070.operation)
	c:RegisterEffect(e2)
end
function c12220070.atkval(e,c)
	return Duel.GetMatchingGroupCount(aux.TRUE,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*500
end
function c12220070.op1(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c12220070.atkval)
		c:RegisterEffect(e1)
end
function c12220070.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk)
end
function c12220070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  and c12220070.filter(chkc) end
	if chk==0 then return Duel.GetMatchingGroupCount(c12220070.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c12220070.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e:GetHandler():GetAttack())
	local atk=g:GetFirst():GetTextAttack()
	if atk<0 then atk=0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c12220070.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
