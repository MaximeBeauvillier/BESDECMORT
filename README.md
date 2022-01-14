# Projet Modélisation numérique des écoulements incompressible
### Desmolin Basile, Trabichet Dorian, Beauvillier Maxime, Roland-Gaubert Matthieu
### INP ENSEEIHT


## Objectif
Le projet consiste à simuler numériquement un écoulement incompressible dans une cavité avec une plaque mobile sur le dessus qui entraîne le fluide.

## Utilisation du code
Il y a deux moyen d'utiliser ce code. 
Le premier est de modifier le fichier param.txt, puis de compilier via la commande "make" et enfin executer le code via la commande "./cavite.exe.
Le second est d'utiliser le script python afin de tester plusieurs configuration. La commande est alors "python3 script_python.py".


## Description du code
Pour lancer le code, les paramètres doivent être écrits dans param.txt Nx et Ny correspondent au nombre de cellules dans chacune des directions x et y, Re est le nombre de Reynolds et tf le temps final souhaité pour la simulation. Le schéma peut être choisi aussi avec 1 : upwind et 2 : centré. dt_storage correspond à l'intervalle de temps réel entre 2 enregistrements successifs.

La subroutine initialisation initialise le domaine avec une vitesse nulle hormis pour la plaque qui a une vitesse de 1 (adimensionnelle). Pour la résolution, le pas de temps adaptatif est calculé d'abord.

La subroutine condition limite traduit la vitesse de la plaque mobile en haut ainsi que des vitesses nulles sur les autres parois.

Les subroutines rhs_u et rhs_v calculent par schéma centré les seconds membres des équations de vitesse qui correspondent aux termes de diffusion.

Les subroutines calcul_uetoile et calcul_vetoile donnent la prédiction de vitesse respectivement pour u et v par un schéma centré ou upwind selon le choix effectué au début.

Le calcul de la pression à l'instant suivant se fait via les subroutines matgen_cavite (calcul de la matrice des coefficients) et ICCG2.

A la suite de ce calcul de pression, la vitesse est corrigée afin d'assurer la condition d'incompressibilité.

Pour l'affichage sous Paraview, on calcule les vitesses u et v au centre des cellules. Par ailleurs les subroutines calcul_rot et calcul_div retournent le rotationnel et la divergence de la vitesse. Pour la génération des fichiers utiles pour la visualisation sous Paraview on utilise la subroutine write_result_ensight.

Pour le post-traitement, on utilise le fichier steady_condition.f90 qui présente plusieurs méthodes utilisées pour connaître la durée avant d'atteindre le régime stationnaire. Le fichier test_convergence.f90 est appelé à chaque itération pour calculer les valeurs pour chacune des méthodes. Le fichier profile.f90 donne accès aux profils de vitesse u ou v suivant une ligne horizontale ou verticale située au milieu du domaine.
