--卡缇娅的最后绝唱
function c60602019.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60602019.spcon)
	e1:SetOperation(c60602019.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	c:EnableReviveLimit()
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c60602019.descon)
	e3:SetTarget(c60602019.destg)
	e3:SetOperation(c60602019.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCondition(c60602019.tgcon)
	e4:SetTarget(c60602019.tgtg)
	e4:SetOperation(c60602019.tgop)
	c:RegisterEffect(e4)
	if not c60602019.global_check then
		c60602019.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetLabel(60602019)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
	end
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_TO_HAND)
	e5:SetRange(LOCATION_HAND+LOCATION_DECK)
	e5:SetOperation(c60602019.operation)
	c:RegisterEffect(e5)
end
function c60602019.check(g)
	local a1=false
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==60602018 then a1=true
		end
		tc=g:GetNext()
	end
	return a1 
end
function c60602019.operation(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_EXODIA = 0x20
	local g1=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local wtp=c60602019.check(g1)
	if wtp and not wntp then
		Duel.ConfirmCards(1-tp,g1)
		Duel.Win(1-tp,WIN_REASON_EXODIA)
	end
end
function c60602019.spfilter1(c,ft,tp)
	if c:GetSequence()<5 then ft=ft+1 end
	return  c:IsCode(60602007)  and c:IsAbleToGraveAsCost()
		and ft>-1 and Duel.IsExistingMatchingCard(c60602019.spfilter2,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c60602019.spfilter2(c,ft)
	return  c:IsAbleToGraveAsCost() and not c:IsCode(60602007) and (ft>0 or c:GetSequence()<5)
end
function c60602019.cfilter(c)
	return c:IsCode(60602001)
end
function c60602019.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-2 and Duel.IsExistingMatchingCard(c60602019.spfilter1,tp,LOCATION_MZONE,0,1,nil,ft,tp) and Duel.IsExistingMatchingCard(c60602019.cfilter,p,LOCATION_MZONE,0,1,nil)
end
function c60602019.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c60602019.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,ft,tp)
	local tc=g1:GetFirst()
	if tc:GetSequence()<5 then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c60602019.spfilter2,tp,LOCATION_MZONE,0,1,1,nil,ft)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c60602019.desfilter(c)
return not c:IsCode(60602019)
end
function c60602019.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c60602019.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c60602019.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c60602019.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c60602019.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
	local ct=Duel.Destroy(g,REASON_EFFECT,LOCATION_GRAVE)
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(ct*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e2:SetValue(ct*500)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e2)
		end
	end
end
function c60602019.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(60602019)~=0
end
function c60602019.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c60602019.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)  then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end