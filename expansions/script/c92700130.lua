--Peach
function c92700130.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xfff7),aux.FilterBoolFunction(Card.IsRace,RACE_CREATORGOD),true)  
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_ONFIELD,0,aux.tdcfop(c))
	--Recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c92700130.cost)
	e1:SetOperation(c92700130.operation)
	c:RegisterEffect(e1)
end
function c92700130.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c92700130.operation(e,tp,eg,ep,ev,re,r,rp)
 Duel.Recover(tp,1000,REASON_EFFECT) 
end
