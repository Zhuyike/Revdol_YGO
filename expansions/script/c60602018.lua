--卡缇娅的神圣之羽
function c60602018.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60602018.spcon)
	e1:SetOperation(c60602018.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.FALSE)
	c:RegisterEffect(e2)
	c:EnableReviveLimit()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c60602018.val)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(c60602018.val)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOGRAVE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCondition(c60602018.tgcon)
	e5:SetTarget(c60602018.tgtg)
	e5:SetOperation(c60602018.tgop)
	c:RegisterEffect(e5)
	if not c60602018.global_check then
		c60602018.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetLabel(60602018)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
	end
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_TO_HAND)
	e6:SetRange(LOCATION_HAND+LOCATION_DECK)
	e6:SetOperation(c60602018.operation)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetOperation(c60602018.operation2)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_UPDATE_ATTACK)
	e8:SetValue(c60602018.val2)
	c:RegisterEffect(e8)
	local e9=e4:Clone()
	e9:SetValue(c60602018.val2)
	c:RegisterEffect(e9)
end
function c60602018.check(g)
	local a1=false
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==60602019 then a1=true
		end
		tc=g:GetNext()
	end
	return a1 
end
function c60602018.operation(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_EXODIA = 0x20
	local g1=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local wtp=c60602018.check(g1)
	if wtp and not wntp then
		Duel.ConfirmCards(1-tp,g1)
		Duel.Win(1-tp,WIN_REASON_EXODIA)
	end
end
function c60602018.operation2(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_EXODIA = 0x20
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local wtp=c60602018.check(g1)
	if wtp and not wntp then
		Duel.ConfirmCards(1-tp,g1)
		Duel.Win(1-tp,WIN_REASON_EXODIA)
	end
end
function c60602018.spfilter1(c,ft,tp)
	if c:GetSequence()<5 then ft=ft+1 end
	return  c:IsCode(60602007)  and  c:IsAbleToGraveAsCost()
		and ft>-1 and Duel.IsExistingMatchingCard(c60602018.spfilter2,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c60602018.spfilter2(c,ft)
	return  c:IsAbleToGraveAsCost() and not c:IsCode(60602007) and (ft>0 or c:GetSequence()<5)
end
function c60602018.cfilter(c)
	return c:IsCode(60602000)
end
function c60602018.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-2 and Duel.IsExistingMatchingCard(c60602018.spfilter1,tp,LOCATION_MZONE,0,1,nil,ft,tp) and Duel.IsExistingMatchingCard(c60602018.cfilter,p,LOCATION_MZONE,0,1,nil)
end
function c60602018.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c60602018.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,ft,tp)
	local tc=g1:GetFirst()
	if tc:GetSequence()<5 then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c60602018.spfilter2,tp,LOCATION_MZONE,0,1,1,nil,ft)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c60602018.chgfilter(c)
	return c:IsFaceup()
end
function c60602018.val(e,c)
	return Duel.GetCounter(c:GetControler(),1,0,0x10ff)*800 
end
function c60602018.val2(e,c)
	return  Duel.GetMatchingGroupCount(c60602018.chgfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_MONSTER)*200
end
function c60602018.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(60602018)~=0
end
function c60602018.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c60602018.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)  then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end