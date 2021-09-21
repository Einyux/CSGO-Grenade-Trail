/* ========================================================================= */
/* SourceMod Plugin - CSGO :: Grenade Trail                                  */
/* ========================================================================= */
/* Copyright (C) 2021, Michael "Einyux" Dos Santos <einyux@gmail.com>        */
/* ========================================================================= */
/* This program is free software: you can redistribute it and/or modify      */
/* it under the terms of the GNU General Public License as published by      */
/* the Free Software Foundation, either version 3 of the License, or         */
/* (at your option) any later version.                                       */
/*                                                                           */
/* This program is distributed in the hope that it will be useful,           */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the              */
/* GNU General Public License for more details.                              */
/*                                                                           */
/* You should have received a copy of the GNU General Public License         */
/* along with this program. If not, see <https://www.gnu.org/licenses/>.     */
/* ========================================================================= */

/* ========================================================================= */
/* Pragmas ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

#pragma semicolon 1
#pragma newdecls  required

/* ========================================================================= */
/* Includes :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

/* ========================================================================= */
/* Defines ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

#define PLUGIN_NAME        "CSGO :: Grenade Trail"
#define PLUGIN_AUTHOR      "Einyux"
#define PLUGIN_DESCRIPTION ""
#define PLUGIN_VERSION     "1.0.0"
#define PLUGIN_URL         "https://github.com/Einyux/CSGO-Grenade-Trail"

/* ========================================================================= */
/* Enums ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

enum GrenadeType
{
    GRENADE_TYPE_EXPLOSIVE  = (0),
    GRENADE_TYPE_FLASHBANG  = (1),
    GRENADE_TYPE_SMOKE      = (2),
    GRENADE_TYPE_DECOY      = (3),
    GRENADE_TYPE_INCENDIARY = (4),
    GRENADE_TYPE_SENSOR     = (5),
    GRENADE_TYPE_MAXIMUM    = (6)
};

/* ========================================================================= */
/* Enum structs :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

enum struct Cvars
{
    int dummy;
}

enum struct Materials
{
    int beamIndex;
    int haloIndex;
}

/* ========================================================================= */
/* Global variables :::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

public Plugin myinfo =
{
    name        = PLUGIN_NAME,
    author      = PLUGIN_AUTHOR,
    description = PLUGIN_DESCRIPTION,
    version     = PLUGIN_VERSION,
    url         = PLUGIN_URL
};

/* ------------------------------------------------------------------------- */

Cvars     gl_cvars;
Materials gl_materials;

StringMap gl_grenadeProjectileClassnameToGrenadeType;

/* ========================================================================= */
/* Functions ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ========================================================================= */

/* ------------------------------------------------------------------------- */
/* Functions - Plugin :::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

public void OnPluginStart()
{
    InitializeCvars();

    gl_grenadeProjectileClassnameToGrenadeType = new StringMap();
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("hegrenade_projectile",    GRENADE_TYPE_EXPLOSIVE);
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("flashbang_projectile",    GRENADE_TYPE_FLASHBANG);
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("smokegrenade_projectile", GRENADE_TYPE_SMOKE);
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("decoy_projectile",        GRENADE_TYPE_DECOY);
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("molotov_projectile",      GRENADE_TYPE_INCENDIARY);
    gl_grenadeProjectileClassnameToGrenadeType.SetValue("tagrenade_projectile",    GRENADE_TYPE_SENSOR);
}

/* ------------------------------------------------------------------------- */
/* Functions - Cvars ::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

void InitializeCvars()
{
    /* ... */
}

/* ------------------------------------------------------------------------- */
/* Functions - Map ::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

public void OnMapStart()
{
    gl_materials.beamIndex = PrecacheModel("materials/sprites/laserbeam.vmt");
    gl_materials.haloIndex = PrecacheModel("materials/sprites/halo.vmt");
}

/* ------------------------------------------------------------------------- */
/* Functions - Entity :::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

public void OnEntityCreated(int index, const char[] classname)
{
    if (gl_grenadeProjectileClassnameToGrenadeType.ContainsKey(classname))
    {
        SDKHook(index, SDKHook_SpawnPost, OnGrenadeProjectileSpawnPost);
    }
}

/* ------------------------------------------------------------------------- */

int GetEntityOwnerEntityIndex(int index)
{
    return GetEntPropEnt(index, Prop_Send, "m_hOwnerEntity");
}

/* ------------------------------------------------------------------------- */
/* Functions - Player :::::::::::::::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------- */
/* Functions - Grenade Projectile :::::::::::::::::::::::::::::::::::::::::: */
/* ------------------------------------------------------------------------- */

void OnGrenadeProjectileSpawnPost(int index)
{
    /* ... */
}

/* ========================================================================= */
