--噩梦型李清歌
function c12220300.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,12220290,1,false,true)
	aux.AddContactFusionProcedure(c,c12220300.filter_nightmare,LOCATION_EXTRA,0,Duel.SendtoGrave,REASON_COST)
	--des
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12220300,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c12220300.target)
	e1:SetOperation(c12220300.activate)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_FZONE,0)
	e2:SetTarget(c12220300.tgtg)
	e2:SetValue(c12220300.efilter_spell)
	c:RegisterEffect(e2)	 
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TODECK)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c12220300.destg)
	e3:SetOperation(c12220300.desop)
	c:RegisterEffect(e3)
end
function c12220300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c12220300.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c12220300.efilter_spell(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c12220300.tgtg(e,c)
	return c:IsCode(92700190)
end
function c12220300.filter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsFaceup()
end
function c12220300.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c12220300.filter,tp,0,LOCATION_SZONE+LOCATION_FZONE,1,nil)>0 end
	local g=Duel.GetMatchingGroup(c12220300.filter,tp,0,LOCATION_SZONE+LOCATION_FZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c12220300.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c12220300.filter,tp,0,LOCATION_SZONE+LOCATION_FZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
		Duel.BreakEffect()
		local dg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c12220300.bkfilter),tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
		if dg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(12220300,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		Duel.SendtoDeck(dg:Select(tp,1,5,nil),nil,2,REASON_EFFECT)
		end
	end
end
function c12220300.bkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c12220300.filter_nightmare(c)
	local tp=c:GetControler()
	return c:IsAbleToGraveAsCost() and Duel.IsEnvironment(92700190,tp)
end