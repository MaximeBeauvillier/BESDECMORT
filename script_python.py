import os
import time
import numpy as np
import matplotlib.pyplot as plt

Nx = [16]
Ny = [16]

def recup_valeur(data,Nx,norme):
    
	data = open(data,"r") 
	contenu_data = data.read()
	data.close()
	liste_data = contenu_data.split("\n")
	print(liste)
	


path = "/home/basile/Documents/Ecole_ing/3A/incompressible/v2/BES_MNEI-main"

for i in range(len(Nx)):
	f=open (path + "param.txt",'w')	
	f.write(str(Nx[i])+'\n')
	f.write(str(Ny[i]) + '\n') 
	f.write(str(1) + '\n') #Nz
	f.write(str(1) + '\n')  #schema (1-> upwind, 2 ->centre)
	f.write(str(400.) + '\n')  #Re
	f.write(str(10.)) #tf
	f.writer(str(1e-4)) #epsilon
	f.close()
	os.system("./cavite.exe")
	recup_resid_valeur(path + "kinetic.dat", Nx[i])
	os.system("rm *.scl")
	os.system("rm *.vec")
	os.system("rm *.geo")
	os.system("rm *.case")
