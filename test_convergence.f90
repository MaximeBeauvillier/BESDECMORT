subroutine test_conv(u_cent, v_cent, nx,ny, dnormeinfu, dnormeinfv, dnorme2u, dnorme2v,  dnorme1u, dnorme1v,dkinetic, time)
	implicit none
	
	integer, intent(in) :: nx,ny
	real*8, dimension(1:nx,1:ny):: u_cent, v_cent
	real*8 :: kinetic_energy, norme1, norme2, normeinf
	real*8, intent(inout) :: dkinetic
	real*8, intent(inout) :: dnorme1u, dnorme1v
	real*8, intent(inout) :: dnorme2u, dnorme2v
	real*8, intent(inout) :: dnormeinfu, dnormeinfv
	real*8, intent(in) :: time
	
	
	!Test de convergence pour l'energie cinetique
	dkinetic = kinetic_energy(u_cent,v_cent,nx,ny)
	open(11, file = 'kinetic.dat', position="append")
	write(11,*) dkinetic	
	close(11)
	
	

	!Test de convergence avec la norme1 de la vitesse
	dnorme1u = norme1(u_cent,nx,ny)
	dnorme1v = norme1(v_cent,nx,ny)

	open(11, file = 'norme_1_u.dat', position="append")
	write(11,*) dnorme1u
	close(11)
	

	open(11, file = 'norme_1_v.dat', position="append")
	write(11,*) dnorme1v
	close(11)		

	
	
	!Test de convergence avec la norme2 de la vitesse
	dnorme2u = norme2(u_cent,nx,ny)
	dnorme2v = norme2(v_cent,nx,ny)

	open(11, file = 'norme_2_u.dat', position="append")
	write(11,*) dnorme2u
	close(11)		

	open(11, file = 'norme_2_v.dat', position="append")
	write(11,*) dnorme2v	
	close(11)	


	!Test de convergence avec la norme2inf de la vitesse
	dnormeinfu = normeinf(u_cent,nx,ny)
	dnormeinfv = normeinf(v_cent,nx,ny)

	open(11, file = 'norme_inf_u.dat', position="append")
	write(11,*) dnormeinfu
	close(11)

	open(11, file = 'norme_inf_v.dat', position="append")
	write(11,*) dnormeinfv	
	close(11)

	open(11, file = 'temps.dat', position="append")
	write(11,*) time
	close(11)	



	
	
end subroutine test_conv

