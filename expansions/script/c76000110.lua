--练习型罗兹·巴蕾特
function c76000110.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,99999999,1,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_HAND,0,Duel.SendtoGrave,REASON_COST)	 
end
