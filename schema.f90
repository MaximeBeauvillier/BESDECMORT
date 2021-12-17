
!Penser a inliner les fcts
!Faire comparer perf


!************************************************************




function upwindE(u , nx, ny, i, j)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(nx,ny), intent(in) ::  u
	integer*8, intent(in) :: i,j
	real*8 :: moy
	real*8 :: upwindE

	moy  = ((u(i+1,j) + u(i,j))/2)
	upwindE = moy - sign(1.,moy)*(0.5 *(u(i+1,j) -u(i,j)))

end function upwindE



!****************************************************



function upwindO(u , nx, ny, i, j) 
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(nx,ny), intent(in) ::  u
	integer*8, intent(in) :: i,j
	real*8 :: moy
	real*8 :: upwindO

	moy  = ((u(i,j) + u(i-1,j))/2)
	upwindO = moy - sign(1.,moy)*(0.5 *(u(i,j) -u(i-1,j)))

end function upwindO




!***********************************************************




function upwindN(u,  nx, ny, i, j)
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(nx,ny), intent(in) ::  u
	integer*8, intent(in) :: i,j
	real*8 :: moy
	real*8 :: upwindN

	moy  = ((u(i,j+1) + u(i,j))/2)
	upwindN = moy - sign(1.,moy)*(0.5 *(u(i,j+1) -u(i,j)))

end function upwindN



!***********************************************************





function upwindS(u, nx, ny, i, j) 
	implicit none

	
	integer*8, intent(in) :: nx,ny
	real*8, dimension(nx,ny), intent(in) ::  u
	integer*8, intent(in) :: i,j
	real*8 :: moy
	real*8 :: upwindS

	moy  = ((u(i,j) + u(i,j-1))/2)
	upwindS = moy - sign(1.,moy)*(0.5 *(u(i,j) -u(i,j-1)))

end function upwindS
 
