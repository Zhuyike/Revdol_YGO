--三岁嗔顽
function c60602015.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60602015,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(c60602015.damcon)
	e2:SetTarget(c60602015.damtg)
	e2:SetOperation(c60602015.damop)
	c:RegisterEffect(e2)
   -- local e3=Effect.CreateEffect(c)
   -- e3:SetDescription(aux.Stringid(60602015,0))
   -- e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
   -- e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
   -- e3:SetRange(LOCATION_MZONE)
   -- e3:SetTarget(c60602015.sptg)
   -- e3:SetOperation(c60602015.spop)
   -- c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c60602015.ctop)
	c:RegisterEffect(e4)
end
function c60602015.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	return c==e:GetHandler() and c:GetBattlePosition()==POS_FACEUP_DEFENSE
end
function c60602015.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk ==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,0)
end
function c60602015.damop(e,tp,eg,ep,ev,re,r,rp)

	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local lp1=Duel.GetLP(p)
	Duel.Damage(p,Duel.GetAttacker():GetAttack()/2,REASON_EFFECT)
	local lp2=Duel.GetLP(p)
	if lp2<lp1 then
		e:GetHandler():RegisterFlagEffect(60602015,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetDescription(aux.Stringid(60602015,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c60602015.sptg)
	e3:SetOperation(c60602015.spop)
	e:GetHandler():RegisterEffect(e3)
	end
end
function c60602015.filter(c,e,tp)
	return c:IsLevelBelow(5) and c:IsRace(RACE_PSYCHO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60602015.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c60602015.filter(chkc,e,tp) end
	if chk==0 then return true end 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c60602015.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
	--Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	   -- and Duel.IsExistingMatchingCard(c60602015.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
   -- Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c60602015.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if  Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c60602015.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
  --  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	--local g=Duel.SelectMatchingCard(tp,c60602015.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	--if g:GetCount()>0 then
	  --  Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
function c60602015.cfilter(c)
	return c:GetAttackAnnouncedCount()==0
end
function c60602015.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c60602015.cfilter,1,nil,1-tp) then
		e:GetHandler():AddCounter(0x10ff,1)
	end
end