--卡缇娅的神圣之羽
function c60602018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c60602018.condition)
	e1:SetTarget(c60602018.target)
	e1:SetOperation(c60602018.activate)
	c:RegisterEffect(e1)
end
function c60602018.filter(c,p)
	return c:GetControler()==p and c:IsOnField() and c:IsSetCard(0xff01) and c:IsType(TYPE_MONSTER)
end
function c60602018.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tg:FilterCount(c60602018.filter,nil,tp)
end
function c60602018.sfilter(c,e,tp)
	return c:IsCode(76000060) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60602018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c60602018.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if not tc:IsDisabled() then
		if Duel.NegateEffect(ev) and tc:IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
			local sc=Duel.GetFirstMatchingCard(c60602018.sfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
			if sc and Duel.GetLocationCountFromEx(tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(60602018,0)) then
				Duel.BreakEffect()
				Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
