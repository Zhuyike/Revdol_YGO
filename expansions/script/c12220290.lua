--伊贞型李清歌
function c12220290.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,3,false,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_EFFECT)	
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12220290,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c12220290.descost)
	e1:SetTarget(c12220290.destg)
	e1:SetOperation(c12220290.desop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12220290,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c12220290.condition)
	e2:SetTarget(c12220290.bktg)
	e2:SetOperation(c12220290.bkop)
	c:RegisterEffect(e2) 
end
function c12220290.costfilter(c)
	return c:IsSetCard(0xff04) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c12220290.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12220290.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c12220290.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c12220290.desfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsAttack(c:GetBaseAttack())
end
function c12220290.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c12220290.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>0 end
	local sg=Duel.GetMatchingGroup(c12220290.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	if sg:GetCount()~=0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetCount()*1000)
	end
end
function c12220290.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c12220290.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct~=0 then
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
		Duel.Recover(tp,1000,REASON_EFFECT)
	end
end
function c12220290.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsAttack(c:GetBaseAttack())
end
function c12220290.bkfilter(c,e,tp)
	return c:IsCode(99999999) 
end
function c12220290.bktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
	Duel.IsExistingMatchingCard(c12220290.bkfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c12220290.bkop(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c12220290.bkfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
end