# Makefile 
# Nom du compilateur
FC = gfortran  

# Options de compilation: optimisation, debug etc...
OPT = -ffpe-trap=invalid,zero,overflow -g
# nom de l'executable
EXE = cavite.exe
# Options de l'edition de lien..
LINKOPT =  

# Defining the objects (OBJS) variables

OBJS =  \
       main.o \
       matgen_cavite.o \
       Solveur.o \
       ensight_cavite.o \
       init.o \
       pas_de_tps.o \
       calcul_etoile.o \
       calcul_rhs.o \
       calcul_dif.o \
       steady_condition.o \
       profile.o

# Linking object files
exe :   $(OBJS)
	$(FC) $(LINKOPT) $(MODS) $(OBJS)  -o $(EXE) 

main.o : main.f90
	$(FC) -c $(OPT)  main.f90

pas_de_tps.o : pas_de_tps.f90
	$(FC) -c $(OPT) pas_de_tps.f90

matgen_cavite.o : matgen_cavite.f90
	$(FC) -c $(OPT) matgen_cavite.f90

Solveur.o : Solveur.f90
	$(FC) -c $(OPT) Solveur.f90


ensight_cavite.o : ensight_cavite.f90
	$(FC) -c $(OPT) ensight_cavite.f90

init.o : init.f90
	$(FC) -c $(OPT) init.f90


calcul_etoile.o : calcul_etoile.f90
	$(FC) -c $(OPT) calcul_etoile.f90


calcul_rhs.o  : calcul_rhs.f90
	$(FC) -c $(OPT) calcul_rhs.f90

calcul_dif.o  : calcul_dif.f90
	$(FC) -c $(OPT) calcul_dif.f90	
	
steady_condition.o  : steady_condition.f90
	$(FC) -c $(OPT) steady_condition.f90
	
profile.o  : profile.f90
	$(FC) -c $(OPT) profile.f90	

	

# Removing object files
clean :
	/bin/rm -f $(OBJS) $(EXE)  *.mod
	rm *.scl
	rm *.vec

config :
	if [ ! -d obj ] ; then mkdir obj ; fi
	if [ ! -d run ] ; then mkdir run ; fi
