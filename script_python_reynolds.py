import os
import time
import numpy as np
import matplotlib.pyplot as plt

Re = [10.,50.,100.,200.]
N = [16,32,64]


def recup_valeur(data,Re,norme):
    
	valeur_data = np.loadtxt(data)
	temps = np.loadtxt(path+'temps.dat')
	it_max = min(len(temps),len(valeur_data))
	if (norme == 'kinetic'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Energie cinétique en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Energie cinétique")
		plt.savefig("Energie_cinetique_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'norme1_u'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme 1 de u en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme 1 de u")
		plt.savefig("Norme_1_u_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'norme1_v'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme 1 de v en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme 1 de v")
		plt.savefig("Norme_1_v_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'norme2_u'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme 2 de u en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme 2 de u")
		plt.savefig("Norme_2_u_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'norme2_v'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme 2 de v en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme 2 de v")
		plt.savefig("Norme_2_v_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'normeinf_u'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme infini de u en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme infini de u")
		plt.savefig("Norme_inf_u_avec_Re_"+str(Re)+".png" )
		plt.close()
	elif (norme == 'normeinf_v'):
		plt.scatter(temps[1:it_max], valeur_data[1:it_max], marker = 'x',s=2)
		plt.title("Norme infini de v en fonction du temps")
		plt.xlabel("temps")
		plt.ylabel("Norme infini de v")
		plt.savefig("Norme_inf_v_avec_Re_"+str(Re)+".png" )
		plt.close()
		
	


path = "/home/bdesmoli/nosave/incompressible/BES_MNEI-main/"
for j in range(len(N)):
    Nx = N[j]
    os.system('mkdir maillage_'+str(Nx))
    for i in range(len(Re)):
        f=open (path + "param.txt",'w')	
        f.write(str(Nx)+'\n')
        f.write(str(Nx) + '\n') 
        f.write(str(1) + '\n') #Nz
        f.write(str(1) + '\n')  #schema (1-> upwind, 2 ->centre)
        f.write(str(Re[i]) + '\n')  #Re
        f.write(str(30.) + '\n') #tf
        f.write(str(20)+ '\n') #storage
        f.write(str(0.001)) #epsilon
        f.close()
        os.system("make")
        os.system("./cavite.exe")
        recup_valeur(path + "kinetic.dat", Re[i], "kinetic")
        recup_valeur(path + "norme_1_u.dat", Re[i], "norme1_u")
        recup_valeur(path + "norme_1_v.dat", Re[i], "norme1_v")
        recup_valeur(path + "norme_2_u.dat", Re[i], "norme2_u")
        recup_valeur(path + "norme_2_v.dat", Re[i], "norme2_v")
        recup_valeur(path + "norme_inf_u.dat", Re[i], "normeinf_u")
        recup_valeur(path + "norme_inf_v.dat", Re[i], "normeinf_v")
        os.system("mkdir Re_"+str(Re[i]))
        os.system("mv *.dat Re_"+str(Re[i]))
        os.system("mv *.png Re_"+str(Re[i]))
        os.system("make clean")
    os.system("mv Re* maillage_"+str(Nx))

