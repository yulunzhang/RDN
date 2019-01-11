#!/bin/bash
## selfEnsemble=false,
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q10 -noise 10 -selfEnsemble false -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q20 -noise 20 -selfEnsemble false -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q30 -noise 30 -selfEnsemble false -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q40 -noise 40 -selfEnsemble false -dataset Classic5

## selfEnsemble=true,
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q10 -noise 10 -selfEnsemble true -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q20 -noise 20 -selfEnsemble true -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q30 -noise 30 -selfEnsemble true -dataset Classic5
th TestRDN_CAR_Y.lua -model RDN_CAR_Y_Q40 -noise 40 -selfEnsemble true -dataset Classic5








