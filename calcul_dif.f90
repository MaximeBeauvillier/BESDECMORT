subroutine calcul_rot(rot,u,v,nx,ny,dx,dy)
	implicit none

	real*8,dimension(1:nx,1:ny), intent(out) :: rot
	real*8,dimension(0:nx+1,0:ny+1), intent(in) :: u,v
	integer, intent(in) :: nx,ny
	real*8, intent(in) :: dx,dy
	real*8,dimension(1:nx,1:ny) :: diffu,diffv
	integer :: i,j	


	do j=1,ny
		do i=1,nx
			diffv(i,j) = (0.5*(v(i+1,j) + v(i+1,j+1)) - &
 			0.5*(v(i-1,j) + v(i-1,j+1)))/(2.*dx) 
			diffu(i,j) = (0.5*(u(i+1,j+1) + u(i,j+1)) - &
			0.5*(u(i+1,j-1) + u(i,j-1)))/(2.*dy)
			rot(i,j) = diffv(i,j) - diffu(i,j) 
		end do
	end do
end subroutine calcul_rot


subroutine calcul_div(div,u,v,nx,ny,dx,dy)
	implicit none

	real*8,dimension(1:nx,1:ny), intent(out) :: div
	real*8,dimension(0:nx+1,0:ny+1), intent(in) :: u,v
	integer, intent(in) :: nx,ny
	real*8, intent(in) :: dx,dy
	real*8,dimension(1:nx,1:ny) :: diffu,diffv
	integer :: i,j	
	
	do j=1,ny
		do i=1,nx
			diffu(i,j) = (u(i,j)-u(i-1,j))/dx 
			diffv(i,j) = (v(i,j)-v(i,j-1))/dy 
			div(i,j) = diffu(i,j) + diffv(i,j)
		end do
	end do

end subroutine calcul_div

