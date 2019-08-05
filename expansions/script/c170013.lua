--风铃子
function c170013.initial_effect(c)
	c:EnableCounterPermit(0x10ff)
	c:SetCounterLimit(0x10ff,99999)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170013,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c170013.e1con)
	e1:SetOperation(c170013.e1op)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c170013.atk)
	c:RegisterEffect(e2)
end
c170013.counter_add_list={0x10ff}
function c170013.e1con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup()
end
function c170013.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:AddCounter(0x10ff,1)
end
function c170013.atk(e,c)
	return c:GetCounter(0x10ff) * 200
end