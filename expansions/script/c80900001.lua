--墨汐·泳装
function c80900001.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80900001,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c80900001.ntcon)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80900001,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,c80900001)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c80900001.bktg)
	e1:SetOperation(c80900001.bkop)
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
function c80900001.bkfilter(c,e,tp)
	return c:IsCode(99999999) 
end
function c80900001.bktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
	Duel.IsExistingMatchingCard(c80900001.bkfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c80900001.bkop(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c80900001.bkfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
end