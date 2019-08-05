--日漫痴老师
function c170001.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c170001.spcon)
	e2:SetOperation(c170001.spop)
	c:RegisterEffect(e2)
	--summon cannot disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon cannot chain
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c170001.sumsuc)
	c:RegisterEffect(e4)
	--change atk&def
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(170001,0))
	e5:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c170001.atkop)
	c:RegisterEffect(e5)
	--graveyard summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(170001,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c170001.gstg)
	e6:SetOperation(c170001.gsop)
	c:RegisterEffect(e6)
end
function c170001.filter(c,e,tp)
	return c:IsSetCard(0xfff0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c170001.gstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c170001.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c170001.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c170001.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c170001.gsop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c170001.defop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e1:SetValue(c170001.defval)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1,true)
	Duel.SpecialSummonComplete()
end
function c170001.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c170001.changefilter,c:GetControler(),LOCATION_MZONE,0,c)
	local g2=Duel.GetMatchingGroup(c170001.changefilter,1-c:GetControler(),LOCATION_MZONE,0,c)
	local atk=g:GetSum(Card.GetAttack)
	local atk2=g2:GetSum(Card.GetAttack)
	local g=Duel.GetMatchingGroup(c170001.changefilter,c:GetControler(),LOCATION_MZONE,0,c)
	local g2=Duel.GetMatchingGroup(c170001.changefilter,1-c:GetControler(),LOCATION_MZONE,0,c)
	local def=g:GetSum(Card.GetDefense)
	local def2=g2:GetSum(Card.GetDefense)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(atk+atk2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(def+def2)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2,true)
end

function c170001.changefilter(c)
	return c:IsFaceup() and c:IsSetCard(0xfff0)
end
function c170001.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimit(c170001.sumsuc_new)
end
function c170001.sumsuc_new(e,ep,tp)
	return ep==tp
end
function c170001.rfilter(c,tp)
	return c:IsControler(tp) or c:IsFaceup()
end
function c170001.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function c170001.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp):Filter(c170001.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return ft>-3 and rg:GetCount()>2 and (ft>0 or rg:IsExists(c170001.mzfilter,ct,nil,tp))
end
function c170001.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp):Filter(c170001.rfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:Select(tp,3,3,nil)
	elseif ft>-2 then
		local ct=-ft+1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c170001.mzfilter,ct,ct,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=rg:Select(tp,3-ct,3-ct,g)
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c170001.mzfilter,3,3,nil,tp)
	end
	Duel.Release(g,REASON_COST)
end