--沙子是贝拉的
function c170017.initial_effect(c)
	c:EnableCounterPermit(0x10ff)
	c:SetCounterLimit(0x10ff,99999)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170017,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c170017.e1con)
	e1:SetOperation(c170017.e1op)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(170017,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c170017.e3con)
	e3:SetOperation(c170017.e3op)
	c:RegisterEffect(e3)
end
function c170017.e3op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:AddCounter(0x10ff,2)
end
function c170017.filter(c)
	return c:IsFaceup() and (c:IsCode(170031) or c:IsCode(170030))
end
function c170017.e3con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c170017.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c170017.e1con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup()
end
function c170017.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
	local gc=g:GetFirst()
	while gc do
		if gc:IsFaceup() then
			gc:AddCounter(0x10ff,1)
		end
		gc=g:GetNext()
	end
end