subroutine uetoile(nx,ny,u,v,dx,dy,uetoile,schema,rhs)
	implicit none

	real*8, dimension(0:nx=1, 0:ny+1), intent(in) :: u,v
	real*8, intent(in) :: dx,dy,nx,ny
	real*8, dimension(1:nx, 1:ny), intent(in) :: rhs
	real*8, dimension(1:nx, 1:ny), intent(out) :: uetoile
	character(LEN=10), intent(in) :: schema

	if (schema .EQ. 'upwind')
		do j=1, ny
			do i=1, nx
	
				UTE = upwindE(uupwind ,u , nx, ny, i, j)
				UTO = upwindO(uupwind ,u , nx, ny, i, j) 
				UTN = upwindN(uupwind ,u,  nx, ny, i, j) 
				UTS = upwindS(uupwind ,u,  nx, ny, i, j) 

				UmoyE = 0.5*(u(i+1,j) + u (i,j)) 
				Umoy0 = 0.5*(u(i,j) + u (i-1,j)) 
				VmoyN = 0.5*(v(i,j+1) + v(i,j)) 
				VmoyS = 0.5*(v(i,j) + v(i,j-1)) 

				uetoile(i,j) = u(i,j) + rhs(i,j)*dt - &
				(dt/dx)*(UmoyE*UTE -UmoyE*UTO) - (dt/dy)*(VmoyN*UTN - VmoyS*UTS)
			enddo
		enddo
	endif

