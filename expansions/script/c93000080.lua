--螺旋永动兔
function c93000080.initial_effect(c)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMINGS_CHECK_MONSTER+TIMING_DAMAGE_STEP)
	e2:SetCondition(c93000080.spcon)
	e2:SetTarget(c93000080.target)
	e2:SetOperation(c93000080.activate)
	c:RegisterEffect(e2)
	--atk def up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93000080,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c93000080.damcon)
	e2:SetOperation(c93000080.desop)
	c:RegisterEffect(e2)
end
function c93000080.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local val=Duel.GetMatchingGroupCount(Card.IsSetCard,c:GetControler(),LOCATION_MZONE,0,nil,0xff11)*1000
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c93000080.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return re and c:GetSummonType()==SUMMON_TYPE_SPECIAL+1 and re:GetHandler():IsCode(93000080)
end
function c93000080.filter(c)
	return c:IsSetCard(0xff11) and c:IsSetCard(0xff12) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c93000080.spcon(e,c)
	return Duel.GetMatchingGroupCount(c93000080.filter,tp,LOCATION_MZONE,0,nil) > 0
end
function c93000080.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93000080,0xff12,0x11,0,0,6,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c93000080.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,93000080,0xff12,0x11,0,0,6,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_TRAP+TYPE_EFFECT)
	Duel.SpecialSummon(c,1,tp,tp,true,false,POS_FACEUP)
end
