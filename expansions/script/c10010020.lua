--paradox
function c10010020.initial_effect(c)
	--SpecialSummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c10010020.spcon)
	e1:SetCost(c10010020.cost)
	e1:SetOperation(c10010020.operation)
	c:RegisterEffect(e1)	 
end
