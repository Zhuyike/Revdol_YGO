--歌姬的梦魇
function c92700390.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_INITIAL)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c92700390.cost)
	e1:SetTarget(c92700390.target)
	e1:SetOperation(c92700390.activate)
	c:RegisterEffect(e1)
end
function c92700390.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c92700390.filter_geji(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsAbleToRemove() and not c:IsSetCard(0xff08)
end
function c92700390.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700390.filter_geji,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c92700390.filter_nightmare(c,att,e)
	return c:IsSetCard(att) and c:IsSetCard(0xff08) and c:IsCanBeSpecialSummoned(e,0,tp,true,true,POS_FACEUP)
end
function c92700390.get_revdol_att(c)
	if c:IsSetCard(0xfff3) then return ATTRIBUTE_DARK end
	if c:IsSetCard(0xfff5) then return ATTRIBUTE_EARTH end
	if c:IsSetCard(0xfff2) then return ATTRIBUTE_FIRE end
	if c:IsSetCard(0xfff1) then return ATTRIBUTE_LIGHT end
	if c:IsSetCard(0xfff6) then return ATTRIBUTE_WATER end
	if c:IsSetCard(0xfff4) then return ATTRIBUTE_WIND end
end
function c92700390.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c92700390.filter_geji,tp,0,LOCATION_MZONE,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c92700390.filter_geji,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			local attr=c92700390.get_revdol_att(tc)
			local table={}
			table[ATTRIBUTE_DARK]=0xfff3
			table[ATTRIBUTE_EARTH]=0xfff5
			table[ATTRIBUTE_FIRE]=0xfff2
			table[ATTRIBUTE_LIGHT]=0xfff1
			table[ATTRIBUTE_WATER]=0xfff6
			table[ATTRIBUTE_WIND]=0xfff4
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
			Duel.BreakEffect()
			if Duel.IsExistingMatchingCard(c92700390.filter_nightmare,tp,LOCATION_EXTRA,0,1,nil,table[attr],e) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local tg=Duel.SelectMatchingCard(tp,c92700390.filter_nightmare,tp,LOCATION_EXTRA,0,1,1,nil,table[attr],e)
				Duel.SpecialSummon(tg,0,tp,tp,true,true,POS_FACEUP)
			end
		end
	end
end

