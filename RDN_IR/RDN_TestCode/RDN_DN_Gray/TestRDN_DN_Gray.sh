#!/bin/bash
# selfEnsemble=false
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N10 -noise 10 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N30 -noise 30 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N50 -noise 50 -selfEnsemble false -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N70 -noise 70 -selfEnsemble false -dataset Kodak24 

# selfEnsemble=true
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N10 -noise 10 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N30 -noise 30 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N50 -noise 50 -selfEnsemble true -dataset Kodak24 
th TestRDN_DN_Gray.lua -model RDN_DN_Gray_N70 -noise 70 -selfEnsemble true -dataset Kodak24 








