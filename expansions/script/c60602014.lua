--流枫渡人
function c60602014.initial_effect(c)
	c:EnableReviveLimit()
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60602014.spcon)
	c:RegisterEffect(e1)	
	--mill
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c60602014.milcon)
	e2:SetTarget(c60602014.miltg)
	e2:SetOperation(c60602014.milop)
	c:RegisterEffect(e2)
end
function c60602014.cfilter(tc)
	return tc and tc:IsFaceup() and tc:IsCode(92700190)
end
function c60602014.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (c60602014.cfilter(Duel.GetFieldCard(tp,LOCATION_SZONE,5))) 
end
function c60602014.milcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsSetCard(0xff08) and rc:IsType(TYPE_MONSTER)
end
function c60602014.filter(c)
	return c:IsFaceup() 
end
function c60602014.miltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c60602014.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c60602014.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c60602014.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60602014.milop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_END,2)
		e1:SetValue(c60602014.efilter)
		tc:RegisterEffect(e1)
	end
end
function c60602014.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and e:GetOwnerPlayer()~=te:GetOwnerPlayer()
end