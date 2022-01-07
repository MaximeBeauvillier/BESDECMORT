import os
import time
import numpy as np
import matplotlib.pyplot as plt

Nx = [16,32]
Ny = [16,32]

def recup_valeur(data,Nx,norme):
    
	valeur_data = np.loadtxt(data)
	temps = np.loadtxt(path+'temps.dat')
	it_max = min(len(temps),len(valeur_data))
	plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
	plt.title("Energie cinétique en fonction du temps")
	plt.xlabel("temps [s]")
	plt.ylabel("Energie cinétique")
	plt.savefig("Energie_cinetique_avec_Nx_"+str(Nx)+".png" )

	


path = "/home/bdesmoli/nosave/incompressible/BES_MNEI-main/"

for i in range(len(Nx)):
    f=open (path + "param.txt",'w')	
    f.write(str(Nx[i])+'\n')
    f.write(str(Ny[i]) + '\n') 
    f.write(str(1) + '\n') #Nz
    f.write(str(1) + '\n')  #schema (1-> upwind, 2 ->centre)
    f.write(str(400.) + '\n')  #Re
    f.write(str(15.) + '\n') #tf
    f.write(str(0.1)+ '\n') #storage
    f.write(str(0.001)) #epsilon
    f.close()
    os.system("make")
    os.system("./cavite.exe")
    recup_valeur(path + "kinetic.dat", Nx[i], "kinetic")
    os.system("mkdir maillage_"+str(Nx[i]))
    os.system("mv *.dat maillage_"+str(Nx[i]))
    os.system("mv *.png maillage_"+str(Nx[i]))
    os.system("make clean")

