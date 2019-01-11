#!/bin/bash
## selfEnsemble=false,
th TestRDN.lua -model RDN_DF2K_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX8 -degradation BI -scale 8 -selfEnsemble false -dataset Set5

## selfEnsemble=true,
th TestRDN.lua -model RDN_DF2K_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
th TestRDN.lua -model RDN_DF2K_BIX8 -degradation BI -scale 8 -selfEnsemble true -dataset Set5











