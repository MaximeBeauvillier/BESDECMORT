function pas_de_tps(u,v,nu,dx,dy,nx,ny)
	implicit none
	
	real*8 :: dt
	real*8, dimension(0:nx+1,0:ny+1), intent(in) :: u,v
	real*8 , intent(in) :: nu, dx, dy
	integer*8 , intent(in):: nx, ny
	
	dt = 1/(2*(((max(abs(u))/dx) + (max(abs(v))/dy) + 2*nu*((1/(dx*dx)) + (1/(dy*dy))))

end function pas_de_tps
