AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local screemSounds = {Sound("screem_1.ogg"), Sound("screem_2.ogg"), Sound("screem_3.ogg"), Sound("screem_4.ogg"), Sound("screem_5.ogg")}

function SWEP:Initialize()
    self.ammo = 100

    sound.Add({
        name = "bad_music_1",
        channel = CHAN_AUTO,
        volume = 1.0,
        level = 100,
        pitch = 100,
        sound = "bad_sound_1.wav"
    })
    
    sound.Add({
        name = "bad_music_2",
        channel = CHAN_AUTO,
        volume = 1.0,
        level = 100,
        pitch = 100,
        sound = "bad_sound_2.wav"
    })
    
    sound.Add({
        name = "sweet_victory",
        channel = CHAN_AUTO,
        volume = 1.0,
        level = 100,
        pitch = 100,
        sound = "music_sweet_victory.ogg"
    })

    hook.Add("KeyRelease", "StopPrimary", function(ply, key)
        if (IsValid(self) and IsValid(self:GetOwner()) and ply:GetName() == self:GetOwner():GetName() and key == IN_ATTACK) then
            self.AllowDrop = true
            self:SetNextPrimaryFire(CurTime() + 0.5)
            local ow = self:GetOwner()
            self.shootSound:Stop()
            ow:SetWalkSpeed(220)
            ow:SetRunSpeed(220)
        end
    end)

    hook.Add("PlayerDroppedWeapon", "ResetSpeedOnDeath", function(owner, wep)
        if (not IsValid(self)) then return end
        if (not IsValid(owner)) then return end
        if (wep ~= self) then return end
        self.shootSound:Stop()
        owner:SetWalkSpeed(220)
        owner:SetRunSpeed(220)
    end)

    timer.Simple(0.1, function()
        self:PostInit()
    end)
end

local musics = {"bad_music_1", "bad_music_2", "sweet_victory"}

function SWEP:PostInit()
    local randNumb = math.random(100)
    if (randNumb > 10) then
        self.shootSound = CreateSound(self:GetOwner(), musics[math.random(#musics - 1)])
    else
        self.shootSound = CreateSound(self:GetOwner(), musics[3])
    end
end

function SWEP:PrimaryAttack()
    self.AllowDrop = false
    self:SetNextPrimaryFire(CurTime() + 0.5)
    self.nextDamageTime = CurTime() + 1
    self.nextScreemTime = CurTime() + 5
    local ow = self:GetOwner()
    self.shootSound:Play()
    ow:SetWalkSpeed(220 * CLARINET.CVARS.clarinet_slownes)
    ow:SetRunSpeed(220 * CLARINET.CVARS.clarinet_slownes)
end

function SWEP:Think()
    if (not self.shootSound:IsPlaying()) then return end

    self.ammo = self.ammo - CLARINET.CVARS.clarinet_fuel_drain_per_second / 30
    self:SetClip1(self.ammo)

    local ow = self:GetOwner()

    if (self.ammo <= 0) then
        ow:StripWeapon("weapon_clarinet")
        self.shootSound:Stop()
        ow:SetWalkSpeed(220)
        ow:SetRunSpeed(220)
    end

    if (self.nextDamageTime < CurTime()) then
        self.nextDamageTime = CurTime() + 1
        local playersInRange = ents.FindInSphere(self:GetOwner():GetPos(), CLARINET.CVARS.clarinet_radius)

        for i, v in pairs(playersInRange) do
            if (v:IsPlayer() and v:Alive() and v:GetObserverMode() == OBS_MODE_NONE and v:GetName() ~= self:GetOwner():GetName()) then
                if (v:GetTeam() == "traitors") then
                    v:TakeDamage(CLARINET.CVARS.clarinet_damage_to_friendly, ow, self)
                else
                    v:TakeDamage(CLARINET.CVARS.clarinet_damage_to_enemy, ow, self)
                end

                if (math.random(1, 100) < 7 and CurTime() > self.nextScreemTime) then
                    v:EmitSound(screemSounds[math.random(#screemSounds)])
                    self.nextScreemTime = CurTime() + 8
                end
            end
        end
    end

    self:NextThink(CurTime() + 1 / 30)
    return true
end