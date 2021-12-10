
!Penser a inliner les fcts
!Faire comparer perf




!************************************************************




function upwindE(uupwind ,u , nx, ny, i, j) result(uupwind)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in) ::  u
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: uupwind
	integer*8, intent(in) :: i,j
	real*8 :: moy

	moy  = ((u(i+1,j) + u(i,j))/2)
	uupwind = moy - sign(moy)*(0.5 *(u(i+1,j) -u(i,j)))

end function upwindE



!****************************************************



function upwindO(uupwind ,u , nx, ny, i, j) result(uupwind)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in) ::  u
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: uupwind
	integer*8, intent(in) :: i,j
	real*8 :: moy

	moy  = ((u(i,j) + u(i-1,j))/2)
	uupwind = moy - sign(moy)*(0.5 *(u(i,j) -u(i-1,j)))

end function upwindO




!***********************************************************




function upwindN(uupwind ,u,  nx, ny, i, j) result(uupwind)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in) ::  u
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: uupwind
	integer*8, intent(in) :: i,j
	real*8 :: moy

	moy  = ((u(i,j+1) + u(i,j))/2)
	uupwind = moy - sign(moy)*(0.5 *(u(i,j+1) -u(i,j)))

end function upwindN



!***********************************************************





function upwindS(uupwind ,u, nx, ny, i, j) result(uupwind)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in) ::  u
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: uupwind
	integer*8, intent(in) :: i,j
	real*8 :: moy

	moy  = ((u(i,j) + u(i,j-1))/2)
	uupwind = moy - sign(moy)*(0.5 *(u(i,j) -u(i,j-1)))

end function upwindS
 
