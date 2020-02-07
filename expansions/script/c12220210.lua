--清歌的小提琴
function c12220210.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	  
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c12220210.tg1)
	e3:SetOperation(c12220210.op1)
	c:RegisterEffect(e3)
end
function c12220210.filter1(c)
	return c:IsFaceup() 
end
function c12220210.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c12220210.filter1(chkc) end
	if chk==0 then return Duel.GetMatchingGroupCount(c12220210.filter1,tp,LOCATION_MZONE,0,1,nil)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c12220210.filter1,tp,LOCATION_MZONE,0,1,1,nil)

end
function c12220210.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local atk=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)*200
	if  atk==0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end