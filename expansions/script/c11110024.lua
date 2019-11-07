--妖狐的妖冶梦境
function c11110024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)  
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
   -- e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(c11110024.condition)
	e2:SetTarget(c11110024.target)
	e2:SetOperation(c11110024.activate)
	c:RegisterEffect(e2)
end
function c11110024.filter(c,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousSetCard(0xff00)
end
function c11110024.filter2(c)
	return c:IsSetCard(0xff00) 
end
function c11110024.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11110024.filter,1,e:GetHandler(),tp)
end
function c11110024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3)  end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,tp,3)
end
function c11110024.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,3)
	Duel.SendtoGrave(g1,REASON_EFFECT)   
	local g2=g1:Filter(c11110024.filter2,nil) 
	if g2:GetCount()>0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local sg=g2:Select(tp,1,1,nil)
	local tc=sg:GetFirst()
	Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
	end
end