--Types
INSERT INTO Types (Type, Kind) VALUES ('BUILDING_ABU_SIMBEL', 'KIND_BUILDING');

--Buildings; +2 Housing
INSERT INTO Buildings (BuildingType, Name, Description, PrereqCivic, Cost, Housing, AdvisorType, MaxWorldInstances, IsWonder, RequiresPlacement, ObsoleteEra, Quote)
VALUES ('BUILDING_ABU_SIMBEL', 'LOC_BUILDING_ABU_SIMBEL_NAME', 'LOC_BUILDING_ABU_SIMBEL_DESCRIPTION', 'CIVIC_CRAFTSMANSHIP', 180, 2, 'ADVISOR_GENERIC', 1, 1, 1, 'ERA_INDUSTRIAL', 'LOC_BUILDING_ABU_SIMBEL_QUOTE');

--Building_ValidTerrains; Must be constructed on Floodplains (Desert, Plains or Grassland).
INSERT INTO Building_ValidFeatures (BuildingType, FeatureType) SELECT 'BUILDING_ABU_SIMBEL', FeatureType FROM Features WHERE FeatureType = 'FEATURE_FLOODPLAINS';
INSERT INTO Building_ValidFeatures (BuildingType, FeatureType) SELECT 'BUILDING_ABU_SIMBEL', FeatureType FROM Features WHERE FeatureType = 'FEATURE_FLOODPLAINS_PLAINS';
INSERT INTO Building_ValidFeatures (BuildingType, FeatureType) SELECT 'BUILDING_ABU_SIMBEL', FeatureType FROM Features WHERE FeatureType = 'FEATURE_FLOODPLAINS_GRASSLAND';

--Building_YieldChanges; +2 Faith
INSERT INTO Building_YieldChanges (BuildingType, YieldType, YieldChange) VALUES ('BUILDING_ABU_SIMBEL', 'YIELD_FAITH', 2);

-- Grants free Granary for every City.
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES ('ABU_SIMBEL_CITIES_FREE_GRANARY', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES ('ABU_SIMBEL_CITY_FREE_GRANARY', 'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE', 1, 1);

INSERT INTO  ModifierArguments (ModifierId, Name, Value) VALUES ('ABU_SIMBEL_CITIES_FREE_GRANARY', 'ModifierId', 'ABU_SIMBEL_CITY_FREE_GRANARY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('ABU_SIMBEL_CITY_FREE_GRANARY', 'BuildingType', 'BUILDING_GRANARY');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_ABU_SIMBEL', 'ABU_SIMBEL_CITIES_FREE_GRANARY');

-- Provides +2 Loyalty for cities with 6 tiles.
INSERT INTO Requirements (RequirementId, RequirementType) VALUES	('REQUIRES_PLOT_HAS_ABU_SIMBEL_WITHIN_6',	'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES	('REQUIRES_PLOT_HAS_ABU_SIMBEL_WITHIN_6',	'BuildingType',	'BUILDING_ABU_SIMBEL'),
        ('REQUIRES_PLOT_HAS_ABU_SIMBEL_WITHIN_6',	'MaxRange',		6),
        ('REQUIRES_PLOT_HAS_ABU_SIMBEL_WITHIN_6',	'MinRange',		0);

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES	('ABU_SIMBEL_WITHIN_6_REQUIREMENTS',	'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES	('ABU_SIMBEL_WITHIN_6_REQUIREMENTS',	'REQUIRES_PLOT_HAS_ABU_SIMBEL_WITHIN_6');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent) VALUES ('ABU_SIMBEL_LOYALTY', 'MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN', 'ABU_SIMBEL_WITHIN_6_REQUIREMENTS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('ABU_SIMBEL_LOYALTY', 'Amount', '2');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_ABU_SIMBEL', 'ABU_SIMBEL_LOYALTY');