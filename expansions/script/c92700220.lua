--红白之战
function c92700220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92700220,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c92700220.descost)
	e1:SetTarget(c92700220.destg1)
	e1:SetOperation(c92700220.desop)
	c:RegisterEffect(e1)  
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(92700220,1))
	e2:SetTarget(c92700220.destg2)
	c:RegisterEffect(e2)
end
function c92700220.costfilter(c)
	return c:IsCode(99999999) and c:IsAbleToGraveAsCost()
end
function c92700220.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92700220.costfilter,tp,LOCATION_HAND,0,1,c) end
	local g=Duel.IsExistingMatchingCard(c92700220.costfilter,tp,LOCATION_HAND,0,1,c)
	Duel.DiscardHand(tp,c92700220.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c92700220.desfilter1(c)
	return c:IsSetCard(0xfff1) or c:IsSetCard(0xfff4) or c:IsSetCard(0xfff6)
end
function c92700220.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField()  end
	if chk==0 then return Duel.IsExistingTarget(c92700220.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c92700220.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c92700220.desfilter2(c)
	return c:IsSetCard(0xfff2) or c:IsSetCard(0xfff3) or c:IsSetCard(0xfff5)
end
function c92700220.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(c92700220.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c92700220.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c92700220.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Destroy(tc,REASON_EFFECT)
	end
end
