--伊贞型玉藻
function c11110001.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,3,false,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_EFFECT)
	--dmg
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110001,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,11110001)
	e1:SetCondition(c11110001.con)
	e1:SetTarget(c11110001.tg)
	e1:SetOperation(c11110001.op)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11110001,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c11110001.spcost)
	e2:SetTarget(c11110001.sptg)
	e2:SetOperation(c11110001.spop)
	c:RegisterEffect(e2)
end
function c11110001.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c11110001.filter(c)
	return c:IsCode(99999999) and c:IsAbleToHand()
end
function c11110001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11110001.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND+CATEGORY_SEARCH,nil,2,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c11110001.spcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.IsExistingMatchingCard(c11110001.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,nil)
end
function c11110001.sppop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c11110001.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c11110001.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,2,2,nil)
		if g:GetCount()>1 then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
		end
	end
end
function c11110001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110001,1))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCondition(c11110001.spcon)
	e1:SetOperation(c11110001.sppop)
	Duel.RegisterEffect(e1,tp)
end
function c11110001.filter_x(c)
	return c:IsSetCard(0xff00) and c:IsType(TYPE_MONSTER)
end
function c11110001.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11110001.filter_x,tp,LOCATION_GRAVE,0,1,nil)
end
function c11110001.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,1,tp,0)
end
function c11110001.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c11110001.filter_x,tp,LOCATION_GRAVE,0,1,nil) then
		local num=Duel.GetMatchingGroupCount(c11110001.filter_x,tp,LOCATION_GRAVE,0,nil)
		Duel.Damage(1-tp,num*300,REASON_EFFECT)
	end
end