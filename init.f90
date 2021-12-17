subroutine initialisation(u,v,nx,ny)
	implicit none
	
	integer*8, intent(in) :: nx,ny 
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: u,v
	integer::i,j

	do j=0,ny+1
		do i =0, nx+1
			v(i,j) = 0.
			u(i,j) = 0.
		enddo
	enddo
	u(:,ny+1) = 2

end subroutine initialisation


subroutine condition_limite(u,v,nx,ny)
	implicit none
	
	real*8, dimension(0:nx+1,0:ny+1), intent(inout) :: u,v	
	integer*8, intent(in) :: nx,ny 

	!Condition pour u
	!***********************************************************
	u(0,:) = 0.
	u(nx,:) = 0.
	u(:,0) = -u(:,1)
	u(:,ny+1) = 2 -u(:,ny)


	!Condition pour v
	!***********************************************************
	v(:,0) = 0.	
	v(:,ny) = 0.
	v(0,:) = -v(1,:)
	v(nx+1,:) = -v(nx,:)



end subroutine condition_limite
