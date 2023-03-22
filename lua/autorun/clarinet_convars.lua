CLARINET = CLARINET or {}
CLARINET.CVARS = CLARINET.CVARS or {}

local clarinet_fuel_drain_per_second = CreateConVar("ttt_clarinet_fuel_drain_per_second", "2.5", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local clarinet_damage_to_friendly = CreateConVar("ttt_clarinet_damage_to_friendly", "4", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local clarinet_damage_to_enemy = CreateConVar("ttt_clarinet_damage_to_enemy", "8", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local clarinet_radius = CreateConVar("ttt_clarinet_radius", "700", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local clarinet_slownes = CreateConVar("ttt_clarinet_slownes", "0.3", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

CLARINET.CVARS.clarinet_fuel_drain_per_second = clarinet_fuel_drain_per_second:GetFloat()
CLARINET.CVARS.clarinet_damage_to_friendly = clarinet_damage_to_friendly:GetInt()
CLARINET.CVARS.clarinet_damage_to_enemy = clarinet_damage_to_enemy:GetInt()
CLARINET.CVARS.clarinet_radius = clarinet_radius:GetInt()
CLARINET.CVARS.clarinet_slownes = clarinet_slownes:GetFloat()

if SERVER then

  cvars.AddChangeCallback("ttt_clarinet_fuel_drain_per_second", function(name, old, new)
    CLARINET.CVARS.clarinet_fuel_drain_per_second = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_clarinet_damage_to_friendly", function(name, old, new)
    CLARINET.CVARS.clarinet_damage_to_friendly = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_clarinet_damage_to_enemy", function(name, old, new)
    CLARINET.CVARS.clarinet_damage_to_enemy = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_clarinet_radius", function(name, old, new)
    CLARINET.CVARS.clarinet_radius = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_clarinet_slownes", function(name, old, new)
    CLARINET.CVARS.clarinet_slownes = tonumber(new)
  end, nil)

end
