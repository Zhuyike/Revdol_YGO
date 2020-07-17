--噩梦型墨汐
function c2250310.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,2250300,1,false,true)
	aux.AddContactFusionProcedure(c,c2250310.filter_nightmare,LOCATION_EXTRA,0,Duel.SendtoGrave,REASON_COST)
	--des
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2250310,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c2250310.target)
	e1:SetOperation(c2250310.activate)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_FZONE,0)
	e2:SetTarget(c2250310.tgtg)
	e2:SetValue(c2250310.efilter_spell)
	c:RegisterEffect(e2)	 
	--Destroy   
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(TIMING_BATTLE_PHASE+TIMING_CHAIN_END)
	e3:SetCondition(c2250310.descon)
	e3:SetCost(c2250310.descost)
	e3:SetTarget(c2250310.destg)
	e3:SetOperation(c2250310.desop)
	c:RegisterEffect(e3)
end
function c2250310.filter_nightmare(c)
	local tp=c:GetControler()
	return c:IsAbleToGraveAsCost() and Duel.IsEnvironment(92700190,tp)
end
function c2250310.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c2250310.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c2250310.efilter_spell(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c2250310.tgtg(e,c)
	return c:IsCode(92700190)
end
function c2250310.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetCurrentChain()==0
		and (e:GetHandler()==Duel.GetAttacker() or e:GetHandler()==Duel.GetAttackTarget())
end
function c2250310.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c2250310.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2250310.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		if Duel.Destroy(g,REASON_EFFECT) then
		Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
		end
	end
end
