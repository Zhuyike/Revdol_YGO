--二次创作周赏
function c92700260.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)   
	--Remove and Recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c92700260.recon)
	e2:SetTarget(c92700260.retg)
	e2:SetOperation(c92700260.reop)
	c:RegisterEffect(e2)  
end
function c92700260.filter(c)
	return c:IsRace(RACE_CREATORGOD) 
end
function c92700260.recon(e,c)
	return  Duel.IsExistingMatchingCard(c92700260.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c92700260.refilter(c)
	return c:IsAbleToRemove() and c:IsSetCard(0xfff7)
end
function c92700260.retg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c92700260.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92700260.refilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c92700260.refilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,nil)
end
function c92700260.reop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Remove(tc,0,REASON_EFFECT)
	Duel.Recover(tp,tc:GetLevel()*200,REASON_EFFECT)
	end
end
	
