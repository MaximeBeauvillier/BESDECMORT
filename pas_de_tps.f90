function pas_de_tps(u,v,nu,dx,dy,nx,ny)
	implicit none
	
	real*8 :: dt
	real*8, dimension(nx,ny), intent(in) :: u,v
	real*8 , intent(in) :: nu, dx, dy
	integer*8 , intent(in):: nx, ny
	real*8 :: pas_de_tps
	
	pas_de_tps = maxval(abs(u))/dx + maxval(abs(v))/dy + 2*nu*(1/(dx*dx)+ 1/(dy*dy))
	pas_de_tps = 1/(2*pas_de_tps)

end function pas_de_tps
