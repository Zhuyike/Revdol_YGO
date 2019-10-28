--枭姬.
function c10010090.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10010090,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c10010090.otcon)
	e1:SetOperation(c10010090.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10010090,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1,10010090)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c10010090.con)
	e3:SetTarget(c10010090.sptg)
	e3:SetOperation(c10010090.spop)
	c:RegisterEffect(e3)
	--des
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TODECK)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c10010090.desth)
	e4:SetTarget(c10010090.thtg)
	e4:SetOperation(c10010090.thop)
	c:RegisterEffect(e4)
end
function c10010090.desth(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY)
end
function c10010090.filter3(c)
	return c:IsAbleToDeck() and c:IsSetCard(0xfff3)
end
function c10010090.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c10010090.filter3(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c10010090.filter3,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c10010090.filter3,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c10010090.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
function c10010090.filter(c)
	return c:IsSetCard(0xfff3) and c:IsFaceup()
end
function c10010090.filter2(c)
	return c:IsFacedown()
end
function c10010090.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c10010090.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c10010090.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c10010090.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>0 and Duel.IsExistingMatchingCard(c10010090.filter2,tp,0,LOCATION_SZONE+LOCATION_FZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,1-tp,LOCATION_SZONE+LOCATION_FZONE)
end
function c10010090.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetMatchingGroupCount(c10010090.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)<=0 and Duel.IsExistingMatchingCard(c10010090.filter2,tp,0,LOCATION_SZONE+LOCATION_FZONE,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c10010090.filter2,tp,0,LOCATION_SZONE+LOCATION_FZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(500)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
function c10010090.otfilter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c10010090.otcon(e,c,minc)
	if c==nil then return true end
	return c:IsLevelAbove(7) and minc<=1 and Duel.CheckTribute(c,1,1,nil) and Duel.IsExistingMatchingCard(c10010090.otfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c10010090.otop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(c10010090.otfilter,tp,LOCATION_MZONE,0,1,nil) then
		local sg=Duel.SelectTribute(tp,c,1,1)
		c:SetMaterial(sg)
		Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	end
end