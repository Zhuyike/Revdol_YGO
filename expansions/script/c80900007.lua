--名称：贝拉·冲浪·全新泳衣
function c80900007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c80900007.target)
	e1:SetOperation(c80900007.operation)
	c:RegisterEffect(e1)
	--Equiplimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c80900007.eqlimit)
	c:RegisterEffect(e3)
	--Search Card
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(80900007,1))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c80900007.drcon)
	e4:SetTarget(c80900007.drtg)
	e4:SetOperation(c80900007.drop)
	c:RegisterEffect(e4)
end
function c80900007.dfilter(c)
	return c:IsCode(99999999) and c:IsAbleToHand() and c:IsLocation(LOCATION_GRAVE)
end
function c80900007.drcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return Duel.GetMatchingGroupCount(c80900007.dfilter,tp,LOCATION_GRAVE,0,nil)>=1 and eg:GetFirst()==ec and Duel.GetAttacker()==ec
end
function c80900007.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	local g=Duel.SelectTarget(tp,c80900007.dfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND+CATEGORY_LEAVE_GRAVE,nil,0,tp,1)
end
function c80900007.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_GRAVE) and tc:IsAbleToHand() then
		Duel.SendtoHand(tc,p,REASON_EFFECT)
	end
end
function c80900007.eqlimit(e,c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c80900007.filter(c)
	return c:IsRace(RACE_CREATORGOD) and c:IsFaceup()
end
function c80900007.rfilter(c)
	return c:IsSetCard(0xfff9) and (not c:IsCode(80900007)) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c80900007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c80900007.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c80900007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.IsExistingMatchingCard(c80900007.rfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c80900007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c80900007.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80900007.rfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
