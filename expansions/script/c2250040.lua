--点兔123
function c2250040.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2250040)
	e1:SetCondition(c2250040.spcon)
	e1:SetTarget(c2250040.sptg)
	e1:SetOperation(c2250040.spop)
	c:RegisterEffect(e1)   
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c2250040.disable)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--avoid battle Damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(EFFECT_CHANGE_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_REMOVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,2250041)
	e3:SetOperation(c2250040.operation)
	c:RegisterEffect(e3)   
end
function c2250040.spfilter(c,sp)
	return c:GetSummonPlayer()==sp
end
function c2250040.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c2250040.spfilter,1,nil,1-tp)
end
function c2250040.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c2250040.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c2250040.disable(e,c)
	return c:IsType(TYPE_EFFECT) and  c:GetSummonType(TYPE_SPSUMMON)
end
function c2250040.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end