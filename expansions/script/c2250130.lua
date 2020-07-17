--阿九
function c2250130.initial_effect(c)
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c2250130.drcon)
	e1:SetTarget(c2250130.drtg)
	e1:SetOperation(c2250130.drop)
	c:RegisterEffect(e1)  
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,2250130)
	e2:SetTarget(c2250130.target)
	e2:SetOperation(c2250130.operation)
	c:RegisterEffect(e2)	 
end
function c2250130.drcon(e,tp,eg,ep,ev,re,r,rp)
	return  Duel.GetTurnPlayer()~=tp
end
function c2250130.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c2250130.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c2250130.filter(c)
	return c:IsSetCard(0xff05) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c2250130.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2250130.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c2250130.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c2250100.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end

