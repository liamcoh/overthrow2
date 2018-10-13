modifier_fountain_aura_effect_lua = class({
	GetTexture = function() return "rune_regen" end,
	GetModifierHealthRegenPercentage = function() return 20 end,
	GetModifierTotalPercentageManaRegen = function() return 20 end,
	GetModifierConstantManaRegen = function() return 30 end,
})

function modifier_fountain_aura_effect_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

if IsServer() then
	function modifier_fountain_aura_effect_lua:OnCreated()
		self:StartIntervalThink(0.1)
	end

	function modifier_fountain_aura_effect_lua:OnIntervalThink()
		local parent = self:GetParent()
		local hasInvulnerability = parent:HasModifier("modifier_disconnect_invulnerable")
		if (
			parent:IsRealHero() and
			DISCONNECT_TIMES[parent:GetPlayerID()] and
			GameRules:GetDOTATime(false, true) - DISCONNECT_TIMES[parent:GetPlayerID()] >= 10
		) and not hasInvulnerability then
			parent:AddNewModifier(parent, nil, "modifier_disconnect_invulnerable", nil)
		elseif not DISCONNECT_TIMES[parent:GetPlayerID()] and hasInvulnerability then
			parent:RemoveModifierByName("modifier_disconnect_invulnerable")
		end
	end

	function modifier_fountain_aura_effect_lua:OnDestroy()
		self:GetParent():RemoveModifierByName("modifier_disconnect_invulnerable")
	end
end
