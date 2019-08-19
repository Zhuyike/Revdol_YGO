--歌姬生活照
function c92700210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,92700210+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c92700210.target)
	e1:SetOperation(c92700210.activate)
	c:RegisterEffect(e1)
end
function c92700210.filter(c)
	return c:IsSetCard(0xfff7) and c:IsFaceup()
end
function c92700210.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92700210.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92700210.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c92700210.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92700210.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(92700210,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(92700210,0))
		e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetProperty(EFFECT_FLAG_DELAY)
		e2:SetLabelObject(tc)
		e2:SetCondition(c92700210.shcon)
		e2:SetTarget(c92700210.shtg)
		e2:SetOperation(c92700210.shop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function c92700210.shcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc) and tc:GetFlagEffect(92700210)~=0
end
function c92700210.shfilter(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c92700210.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700210.shfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92700210.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92700210.shfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
