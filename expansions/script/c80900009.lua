--清歌·沙滩·炭烤海鲜
function c80900009.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetHintTiming(TIMING_DAMAGE_STEP,TIMINGS_CHECK_MONSTER+TIMING_DAMAGE_STEP)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c80900009.drcon) 
	e3:SetTarget(c80900009.drtg)
	e3:SetOperation(c80900009.drop)
	c:RegisterEffect(e3)
end
function c80900009.cfilter(c)
	return  c:IsRace(RACE_CREATORGOD) and  c:GetPreviousLocation()==LOCATION_MZONE 
	and c:GetPreviousControler()==tp 
end
function c80900009.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c80900010.cfilter,1,nil,tp)
end
function c80900009.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c80900009.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)z
	Duel.Draw(p,d,REASON_EFFECT)
end
