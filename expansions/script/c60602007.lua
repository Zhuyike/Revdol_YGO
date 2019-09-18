--蠢凌
function c60602007.initial_effect(c)
	c:EnableReviveLimit()
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60602007.spcon)
	e1:SetTarget(c60602007.sptg)
	e1:SetOperation(c60602007.spop)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=e1:Clone()
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c60602007.spcon2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c60602007.adop)
	c:RegisterEffect(e3)
	--atk
   -- local e3=Effect.CreateEffect(c)
   -- e3:SetType(EFFECT_TYPE_SINGLE)
	--e3:SetCode(EFFECT_SET_ATTACK_FINAL)
   -- e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
   -- e3:SetRange(LOCATION_MZONE)
   -- e3:SetCondition(c60602007.adcon)
   -- e3:SetValue(c60602007.adval)
   -- c:RegisterEffect(e3)
	--den
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e3:SetCondition(c60602007.adcon)
	e4:SetValue(c60602007.deval)
	c:RegisterEffect(e4)
	--atklimit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e5:SetValue(c60602007.atlimit)
	c:RegisterEffect(e5)
end
function c60602007.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0xfff6) and c:IsType(TYPE_MONSTER)
end
function c60602007.filter(c)
	 return c:IsFaceup() 
end
function c60602007.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and (tc:IsSetCard(0xfff6)) and tc:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c60602007.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and (tc:IsSetCard(0xfff6)) and tc:IsSummonType(SUMMON_TYPE_NORMAL)
end
function c60602007.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60602007.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	 Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
end
function c60602007.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c60602007.adval)
	c:RegisterEffect(e1)
end
function c60602007.adcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c60602007.adval(e,c)
	local g=Duel.GetMatchingGroup(c60602007.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val
	end
end
function c60602007.deval(e,c)
	local g=Duel.GetMatchingGroup(c60602007.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then 
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetDefense)
		return val
	end
end
