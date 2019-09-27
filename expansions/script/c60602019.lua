--卡缇娅的最后绝唱
function c60602019.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c60602019.spcon)
	e2:SetOperation(c60602019.spop)
	c:RegisterEffect(e2)
end
function c60602019.mzfilter(c)
	return c:GetSequence()<5
end
function c60602019.filter(c)
	return (c:IsSetCard(0xff01) or c:IsSetCard(0xfff6)) and c:IsAbleToGraveAsCost()
end
function c60602019.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c60602019.filter,tp,LOCATION_MZONE,0,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return mg:GetCount()>0 and (ft>0 or mg:IsExists(c60602019.mzfilter,ct,nil))
end
function c60602019.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c60602019.filter,tp,LOCATION_MZONE,0,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=mg:Select(tp,1,7,nil)
	else
		local ct=-ft+1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		g=mg:FilterSelect(tp,c60602019.mzfilter,ct,ct,nil)
		if mg:GetCount()>ct and Duel.SelectYesNo(tp,210) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g2=mg:Select(tp,1,7,g)
			g:Merge(g2)
		end
	end
	local ct=Duel.SendtoGrave(g,REASON_COST)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(ct*2000)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
	local tc=e:GetHandler()
	local e2=Effect.CreateEffect(tc)
	e2:SetDescription(aux.Stringid(60602019,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c60602019.destg)
	e2:SetOperation(c60602019.desop)
	e2:SetReset(RESET_EVENT+0xee0000)
	tc:RegisterEffect(e2)
end
function c60602019.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c60602019.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Destroy(c,REASON_EFFECT)
end