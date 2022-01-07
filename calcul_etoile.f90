function H(x)    !Heavyside function
	implicit none
	real*8, intent(in) :: x
	real*8 :: H
	real*8 :: one
	one=1.
	H=0.5*(sign(one,x)+1.)
end function H







subroutine calcul_uetoile(nx,ny,u,v,dx,dy,uetoile,schema,rhs,dt)
	implicit none
	integer, intent(in) :: nx,ny
	real*8, dimension(0:nx+1, 0:ny+1), intent(in) :: u,v
	real*8, intent(in) :: dx,dy
	
	real*8, dimension(1:nx, 1:ny), intent(in) :: rhs
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: uetoile
	integer, intent(in) :: schema
	real*8 :: upwindE, upwindS, upwindN, upwindO,H
	real*8 :: UmoyE, VmoyN, VmoyS, UmoyO
	integer*8 :: i,j
	real*8,intent(in) :: dt
	



	do j=1, ny
		do i=1, nx-1
			!calcul des vitesse de transport
			UmoyE = 0.5*(u(i+1,j) + u(i,j)) 
			UmoyO = 0.5*(u(i,j) + u(i-1,j)) 
			VmoyN = 0.5*(v(i+1,j) + v(i,j)) 
			VmoyS = 0.5*(v(i+1,j-1) + v(i,j-1))
			
			!shéma amont
			if (schema == 1) then
				upwindE = H(UmoyE)*u(i,j)+(1.-H(UmoyE))*u(i+1,j)
				upwindO = H(UmoyO)*u(i-1,j)+(1.-H(UmoyO))*u(i,j)
				upwindN = H(VmoyN)*u(i,j)+(1.-H(VmoyN))*u(i,j+1)
				upwindS = H(VmoyS)*u(i,j-1)+(1.-H(VmoyS))*u(i,j)
			endif
			uetoile(i,j) = u(i,j) + rhs(i,j)*dt - &
			(dt/dx)*(UmoyE*upwindE -UmoyO*upwindO) - &
			(dt/dy)*(VmoyN*upwindN - VmoyS*upwindS)
		enddo
	enddo

end subroutine calcul_uetoile






subroutine calcul_vetoile(nx,ny,u,v,dx,dy,vetoile,schema,rhs,dt)
	implicit none
	integer, intent(in) :: nx,ny
	real*8, dimension(0:nx+1, 0:ny+1), intent(in) :: u,v
	real*8, intent(in) :: dx,dy
	
	real*8, dimension(1:nx, 1:ny), intent(inout) :: rhs
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: vetoile
	integer, intent(in) :: schema
	real*8 :: vpwindE, vpwindS, vpwindN, vpwindO,H
	real*8 :: UmoyE, VmoyN, VmoyS, UmoyO
	integer*8 :: i,j
	real*8,intent(in) :: dt
	



	do j=1, ny-1
		do i=1, nx
			!calcul des vitesse de transport
			UmoyE = 0.5*(u(i,j+1) + u(i,j)) 
			UmoyO = 0.5*(u(i-1,j) + u(i-1,j+1)) 
			VmoyN = 0.5*(v(i,j+1) + v(i,j)) 
			VmoyS = 0.5*(v(i,j) + v(i,j-1))
			if (schema == 1) then
				vpwindE = H(UmoyE)*v(i,j)+(1.-H(UmoyE))*v(i+1,j)
				vpwindO = H(UmoyO)*v(i-1,j)+(1.-H(UmoyO))*v(i,j)
				vpwindN = H(VmoyN)*v(i,j)+(1.-H(VmoyN))*v(i,j+1)
				vpwindS = H(VmoyS)*v(i,j-1)+(1.-H(VmoyS))*v(i,j)
			endif
			vetoile(i,j) = v(i,j) + rhs(i,j)*dt - &
			(dt/dx)*(UmoyE*vpwindE -UmoyO*vpwindO) - &
			(dt/dy)*(VmoyN*vpwindN - VmoyS*vpwindS)
		enddo
	enddo

end subroutine calcul_vetoile
