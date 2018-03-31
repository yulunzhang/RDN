#######################################################
###### No self-ensemble: RDN
# BI degradation model, X2, X3, X4
th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble false -dataset Set5
th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble false -dataset Set5
th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble false -dataset Set5
# BD degradation model, X3
th TestRDN.lua -model RDN_BDX3 -degradation BD -scale 3 -selfEnsemble false -dataset Set5
# DN degradation model, X3
th TestRDN.lua -model RDN_DNX3 -degradation DN -scale 3 -selfEnsemble false -dataset Set5


###### With self-ensemble: RDN+
# BI degradation model, X2, X3, X4
th TestRDN.lua -model RDN_BIX2 -degradation BI -scale 2 -selfEnsemble true -dataset Set5
th TestRDN.lua -model RDN_BIX3 -degradation BI -scale 3 -selfEnsemble true -dataset Set5
th TestRDN.lua -model RDN_BIX4 -degradation BI -scale 4 -selfEnsemble true -dataset Set5
# BD degradation model, X3
th TestRDN.lua -model RDN_BDX3 -degradation BD -scale 3 -selfEnsemble true -dataset Set5
# DN degradation model, X3
th TestRDN.lua -model RDN_DNX3 -degradation DN -scale 3 -selfEnsemble true -dataset Set5








