subroutine initialisation(u,v,nx,ny)
	implicit none
	
	integer*8, intent(in) ::nx,ny 
	real*8, dimension(0:nx+1,0:ny+1), intent(out) :: u,v
	integer::i,j

	do j=0,ny+1
		do i =0, nx+1
			v(i,j) = 0.
			u(i,j) = 0.
		enddo
	enddo

	do i=0,nx+1
		u(i,ny+1) = 2
	enddo

end subroutine initialisation
			
