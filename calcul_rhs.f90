subroutine calcul_rhs_u(u,dx,dy,nu,rhs_u,nx,ny)
	implicit none
	integer, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in):: u
	real*8, intent(in) :: dx,dy, nu
	
	real*8,dimension(1:nx,1:ny), intent(out) :: rhs_u
	integer :: i,j
	
	do j=1,ny
		do i=1,nx-1
			rhs_u(i,j) = nu*((u(i+1,j) - 2.*u(i,j) + u(i-1,j))/(dx*dx)) &
			           + nu*((u(i,j+1) - 2.*u(i,j) + u(i,j-1))/(dy*dy))
		end do
	end do	



end subroutine calcul_rhs_u








subroutine calcul_rhs_v(v,dx,dy,nu,rhs_v,nx,ny)
	implicit none
	integer, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in):: v
	real*8, intent(in) :: dx,dy, nu
	
	real*8,dimension(1:nx,1:ny), intent(out) :: rhs_v
	integer :: i,j	
	
	do j=1,ny-1
		do i=1,nx
			rhs_v(i,j) = nu*((v(i+1,j) - 2.*v(i,j) + v(i-1,j))/(dx*dx)) &
				   + nu*((v(i,j+1) - 2.*v(i,j) + v(i,j-1))/(dy*dy))
		end do
	end do	

end subroutine calcul_rhs_v
	

