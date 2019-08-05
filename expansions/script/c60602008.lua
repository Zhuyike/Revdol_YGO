--风
function c60602008.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,60602008)
	e1:SetCondition(c60602008.ats)
	e1:SetTarget(c60602008.sumtg)
	e1:SetOperation(c60602008.sumop)
	c:RegisterEffect(e1)

	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c60602008.desth)
	e2:SetTarget(c60602008.thtg)
	e2:SetOperation(c60602008.thop)
	c:RegisterEffect(e2)
end
function c60602008.ats(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and (Duel.GetAttackTarget() or Duel.GetAttackTarget()==nil)
end
function c60602008.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c60602008.sumop(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
	 Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
function c60602008.desth(e,tp,eg,ep,ev,re,r,rp)
	return  e:GetHandler():IsReason(REASON_BATTLE) 
end
function c60602008.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c60602008.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end