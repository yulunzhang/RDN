#!/bin/bash
# selfEnsemble=false
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N10 -noise 10 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N30 -noise 30 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N50 -noise 50 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N70 -noise 70 -selfEnsemble false -dataset Kodak24 

# selfEnsemble=true
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N10 -noise 10 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N30 -noise 30 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N50 -noise 50 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_RGB.lua -model RDN_DN_RGB_N70 -noise 70 -selfEnsemble true -dataset Kodak24 








