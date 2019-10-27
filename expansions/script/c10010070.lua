--五彩斑斓的金毛
function c10010070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c10010070.rmtarget)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c10010070.sdcon)
	c:RegisterEffect(e3)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10010070,0))
	e4:SetCategory(CATEGORY_DECKDES+CATEGORY_TOGRAVE+CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c10010070.condition)
	e4:SetTarget(c10010070.target)
	e4:SetOperation(c10010070.operation)
	c:RegisterEffect(e4)
end
function c10010070.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10010070.sdfilter,1,nil)
end
function c10010070.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES+CATEGORY_TOGRAVE,nil,0,tp,LOCATION_DECK+LOCATION_HAND)
end
function c10010070.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	if not tc:IsRelateToEffect(e) then return end
	if not tc:IsLocation(LOCATION_SZONE) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c10010070.tgfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 and gc:IsLocation(LOCATION_GRAVE) then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e1:SetTarget(c10010070.distg)
			e1:SetLabelObject(gc)
			e1:SetReset(RESET_PHASE+PHASE_END,1)
			Duel.RegisterEffect(e1,tp)
			local e2=Effect.CreateEffect(tc)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_CHAIN_SOLVING)
			e2:SetCondition(c10010070.discon)
			e2:SetOperation(c10010070.disop)
			e2:SetLabelObject(gc)
			e2:SetReset(RESET_PHASE+PHASE_END,1)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c10010070.distg(e,c)
	local tc=e:GetLabelObject()
	return c:IsOriginalCodeRule(tc:GetOriginalCodeRule())
end
function c10010070.discon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsOriginalCodeRule(tc:GetOriginalCodeRule())
end
function c10010070.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c10010070.tgfilter(c)
	return c:IsSetCard(0xfff7) and c:IsAbleToGrave() and c:IsType(TYPE_MONSTER)
end
function c10010070.sdfilter(c)
	return c:IsSetCard(0xfff7) and c:IsType(TYPE_MONSTER)
end
function c10010070.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10010070.sdfilter,tp,LOCATION_GRAVE,0,10,nil)
end
function c10010070.rmtarget(e,c)
	return c:IsType(TYPE_SPELL)
end