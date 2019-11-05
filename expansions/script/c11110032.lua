--噩梦型神宫司玉藻
function c11110032.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,11110001,1,false,true)
	aux.AddContactFusionProcedure(c,c11110032.filter_nightmare,LOCATION_EXTRA,0,Duel.SendtoGrave,REASON_COST)
	--des
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11110032,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c11110032.target)
	e1:SetOperation(c11110032.activate)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_FZONE,0)
	e2:SetTarget(c11110032.tgtg)
	e2:SetValue(c11110032.efilter_spell)
	c:RegisterEffect(e2)   
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e3:SetTargetRange(0xff,0xff)
	e3:SetTarget(c11110032.rmtarget)
	e3:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e3) 
end
function c11110032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c11110032.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c11110032.efilter_spell(e,te)
	return te:IsActiveType(TYPE_MONSTER)
end
function c11110032.tgtg(e,c)
	return c:IsCode(92700190)
end
function c11110032.ffilter(c)
	return c:IsFaceup() and c:IsCode(92700190)
end
function c11110032.rmtarget(e,c)
	return not c:IsLocation(0x80) and Duel.IsExistingMatchingCard(c11110032.ffilter,tp,LOCATION_ONFIELD,0,1,nil) and not c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c11110032.filter_nightmare(c)
	local tp=c:GetControler()
	return c:IsAbleToGraveAsCost() and Duel.IsEnvironment(92700190,tp)
end