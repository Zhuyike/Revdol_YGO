--Swan型神宫司·玉藻
function c76000030.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,2,true,true)
	aux.AddContactFusionProcedure(c,nil,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c76000030.con)
	e1:SetValue(1)
	c:RegisterEffect(e1) 
	--SearchCard
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,76000030)
	e2:SetTarget(c76000030.setg)
	e2:SetOperation(c76000030.seop)
	c:RegisterEffect(e2)
end
function c76000030.cfilter(tc)
	return tc and tc:IsFaceup()
end
function c76000030.con(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (c76000030.cfilter(Duel.GetFieldCard(tp,LOCATION_SZONE,5)) or c76000030.cfilter(Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)))
end
function c76000030.sefilter(c)
	return c:IsCode(92700001) or (c:IsSetCard(0xff00) and c:IsType(TYPE_FIELD))
end
function c76000030.setg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c76000030.sefilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c76000030.seop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c76000030.sefilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end