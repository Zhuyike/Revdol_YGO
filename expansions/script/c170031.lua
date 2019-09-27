--噩梦 伊莎贝拉•霍利
function c170031.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,170030,1,false,true)
	aux.AddContactFusionProcedure(c,c170031.filter_nightmare,LOCATION_EXTRA,0,Duel.SendtoGrave,REASON_COST)
	--des
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(170031,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c170031.target)
	e1:SetOperation(c170031.activate)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_FZONE,0)
	e2:SetTarget(c170031.tgtg)
	e2:SetValue(c170031.efilter_spell)
	c:RegisterEffect(e2)
	--return deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(170031,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c170031.e2tg)
	e3:SetOperation(c170031.e2op)
	c:RegisterEffect(e3)
end
function c170031.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c:IsAbleToDeck(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,1-tp,LOCATION_ONFIELD)
end
function c170031.e2op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_ONFIELD) then
		Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
	end
end
function c170031.efilter_spell(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c170031.tgtg(e,c)
	return c:IsCode(92700190)
end
function c170031.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c170031.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c170031.filter_nightmare(c)
	local tp=c:GetControler()
	return c:IsAbleToGraveAsCost() and Duel.IsEnvironment(92700190,tp)
end