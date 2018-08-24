update arm_ads_ph
set ID_PH_TYP = decode(ID_PH_TYP, 'HOME', '1', 'CELLULAR', '2', 'ALTERNATE', '4', 'FAX', '5', 'OFFICE', '3', ID_PH_TYP);

UPDATE PA_PRS
SET TY_GND_PRS = DECODE(TY_GND_PRS, 'F', '3', 'M', '2', 'U', '1', TY_GND_PRS);





