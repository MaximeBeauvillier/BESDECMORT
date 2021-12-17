subroutine calcul_uetoile(nx,ny,u,v,dx,dy,uetoile,schema,rhs,dt)
	implicit none

	real*8, dimension(0:nx+1, 0:ny+1), intent(in) :: u,v
	real*8, intent(in) :: dx,dy
	integer*8, intent(in) :: nx,ny
	real*8, dimension(1:nx, 1:ny), intent(in) :: rhs
	real*8, dimension(1:nx, 1:ny), intent(out) :: uetoile
	integer, intent(in) :: schema
	real*8 :: upwindE, upwindS, upwindN, upwindO, UTE, UTO, UTN, UTS
	real*8 :: UmoyE, VmoyN, VmoyS, UmoyO
	integer*8 :: i,j
	real*8,intent(in) :: dt

	if (schema == 1) then
		do j=1, ny
			do i=1, nx
	
				UTE = upwindE(u , nx, ny, i, j)
				UTO = upwindO(u , nx, ny, i, j) 
				UTN = upwindN(u,  nx, ny, i, j) 
				UTS = upwindS(u,  nx, ny, i, j) 

				UmoyE = 0.5*(u(i+1,j) + u (i,j)) 
				UmoyO = 0.5*(u(i,j) + u (i-1,j)) 
				VmoyN = 0.5*(v(i,j+1) + v(i,j)) 
				VmoyS = 0.5*(v(i,j) + v(i,j-1)) 

				uetoile(i,j) = u(i,j) + rhs(i,j)*dt - &
				(dt/dx)*(UmoyE*UTE -UmoyE*UTO) - (dt/dy)*(VmoyN*UTN - VmoyS*UTS)
			enddo
		enddo
	endif
end subroutine calcul_uetoile
