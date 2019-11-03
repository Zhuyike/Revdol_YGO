--清墨·虚空制糖
function c10010240.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xfff3),aux.FilterBoolFunction(Card.IsFusionSetCard,0xfff4),true)   
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_MZONE,0,Duel.SendtoGrave,REASON_COST)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10010240,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,10010240)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c10010240.discon)
	e1:SetTarget(c10010240.distg)
	e1:SetOperation(c10010240.disop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10010240,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetTarget(c10010240.sptg)
	e2:SetOperation(c10010240.spop)
	c:RegisterEffect(e2)
end
function c10010240.spfilter(c)
	return (c:IsSetCard(0xfff3) or c:IsSetCard(0xfff4)) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c10010240.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10010240.spfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c10010240.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10010240.spfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
end
function c10010240.filter_utahime(c)
	return c:IsFaceup() and c:IsLevelAbove(6) and c:IsRace(RACE_CREATORGOD)
end
function c10010240.discon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10010240.filter_utahime,tp,LOCATION_MZONE,0,nil)
	local flag=false
	if g:GetCount()<3 then
		flag=false
	else
		local tc=g:GetFirst()
		local table1={}
		while tc do
			table1[tc:GetCode()]=1
			tc=g:GetNext()
		end
		local num=0
		for k,v in pairs(table1) do
			num=num+1
		end
		if num>2 then
			flag=true
		else
			flag=false
		end
	end
	return (not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)) and flag
end
function c10010240.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10010240.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end