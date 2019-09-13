--本周贡献周榜
function c92700310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_ATKCHANGE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_INITIAL)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c92700310.target)
	e1:SetOperation(c92700310.operation)
	c:RegisterEffect(e1)
end
function c92700310.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,0,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,LOCATION_DECK)
end
function c92700310.filter_revdol(c)
	return c:IsSetCard(0xfff7) and c:IsFaceup()
end
function c92700310.filter_yizhen(c)
	return c:IsCode(99999999) and c:IsAbleToDeck()
end
function c92700310.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c92700310.filter_yizhen,tp,LOCATION_GRAVE,0,nil)
	local ct=Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	if ct>0 then
		Duel.ShuffleDeck(tp)
		if ct>0 then
			local gc=Duel.GetMatchingGroup(c92700310.filter_revdol,tp,LOCATION_MZONE,0,nil)
			local tc=gc:GetFirst()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UPDATE_ATTACK)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				e1:SetValue(300)
				tc:RegisterEffect(e1)
				tc=gc:GetNext()
			end
		end
		if ct>1 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetReset(RESET_PHASE+PHASE_END,2)
			e1:SetTargetRange(1,0)
			e1:SetValue(1)
			Duel.RegisterEffect(e1,tp)
		end
		if ct>2 then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end