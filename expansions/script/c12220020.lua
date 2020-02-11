--六道轮回·君尘
function c12220020.initial_effect(c)
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	--e1:SetCountLimit(1)
	e1:SetCondition(c12220020.remcon1)
	e1:SetTarget(c12220020.remtg)
	e1:SetOperation(c12220020.remop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c12220020.remcon2)
	c:RegisterEffect(e2)   
	--ntsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_REMOVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1)
	e3:SetTarget(c12220020.target)
	e3:SetOperation(c12220020.operation)
	c:RegisterEffect(e3)  
end
function c12220020.remfilter(c)
	return not c:IsAttack(c:GetBaseAttack()) and c:IsAbleToRemove()
end
function c12220020.remcon1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():GetPreviousControler()==tp
end
function c12220020.remcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c12220020.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c12220020.remfilter,tp,0,LOCATION_MZONE,1,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_MZONE)
end
function c12220020.remop(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
   if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c12220020.remfilter,tp,0,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c12220020.rfilter(c)
	return c:GetLevel()>0 and c:IsSetCard(0xff04) and c:IsAttribute(ATTRIBUTE_DARK) 
end
function c12220020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.GetMatchingGroupCount(c12220020.filter,tp,LOCATION_HAND,0,1,nil)>0
	end
end
function c12220020.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12220020,1))
	local g=Duel.SelectMatchingCard(tp,c12220020.filter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(12220020,0))
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c12220020.ntcon)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c12220020.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end