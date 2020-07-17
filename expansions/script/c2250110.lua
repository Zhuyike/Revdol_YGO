--绯世
function c2250110.initial_effect(c)
	--ConfirmCards
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,2250110)
	e1:SetTarget(c2250110.tgtg)
	e1:SetOperation(c2250110.tgop)
	c:RegisterEffect(e1)  
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,2250111)
	e2:SetTarget(c2250110.damtg)
	e2:SetOperation(c2250110.damop)
	c:RegisterEffect(e2)
end
function c2250110.tgfilter(c,e,tp)
	return  c:IsType(TYPE_MONSTER) and (c:IsAbleToGrave() or c:IsAbleToRemove())
end
function c2250110.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c2250110.tgop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=2 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	local ct=g:GetCount()
	if ct>0 and Duel.SelectYesNo(tp,aux.Stringid(2250110,0)) then
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(2250110,1))
		local sg=g:FilterSelect(tp,c2250110.tgfilter,1,1,nil,e,tp)
		if sg:GetCount()>0 then
			local tc=sg:GetFirst()
			if tc and tc:IsAbleToGrave() and (not tc:IsAbleToRemove() or Duel.SelectOption(tp,1191,1192)==0) then
			Duel.SendtoGrave(tc,REASON_EFFECT)
			else
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
			end
			Duel.BreakEffect()
			Duel.Damage(1-tp,300,REASON_EFFECT)
		end
	end
end
function c2250110.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c2250110.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
