--墨汐·泳装
function c80900001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80900001,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c80900001.ntcon)
	c:RegisterEffect(e1)
end
function c80900001.ntfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CREATORGOD)
end
function c80900001.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c80900001.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end