--AVALON♛居士.
function c10010160.initial_effect(c)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c10010160.tgcon)
	e1:SetValue(c10010160.tgtg)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10010160,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetTarget(c10010160.target2)
	e2:SetOperation(c10010160.desop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10010160,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(c10010160.spcon)
	e3:SetTarget(c10010160.target)
	e3:SetOperation(c10010160.activate)
	c:RegisterEffect(e3)
end
function c10010160.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c10010160.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c10010160.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and re:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP) and Duel.IsPlayerCanDraw(tp,2)
end
function c10010160.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c10010160.filter2,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,1-tp,LOCATION_DECK)
end
function c10010160.filter2(c,e,tp)
	return c:IsCode(10010160) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10010160.con(e,tp,eg,ep,ev,re,r,rp)
	return true
end
function c10010160.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c10010160.filter2,tp,LOCATION_DECK,0,2,nil,e,tp) then
		local g=Duel.SelectMatchingCard(tp,c10010160.filter2,tp,LOCATION_DECK,0,2,2,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
end
function c10010160.filter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsSetCard(0xfffb) and c:IsFaceup()
end
function c10010160.tgcon(e)
	return Duel.IsExistingMatchingCard(c10010160.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c10010160.tgtg(e,c)
	return c~=e:GetHandler() and c:IsFaceup()
end