subroutine pas_de_tps(u,v,nu,dx,dy,nx,ny,dt)
	implicit none
	integer , intent(in):: nx, ny
	real*8, dimension(0:nx+1,0:ny+1), intent(in) :: u,v
	real*8 , intent(in) :: nu, dx, dy
	real*8, intent(out) :: dt
	
	dt = 0.5/(maxval(abs(u))/dx + maxval(abs(v))/dy + 2.*nu*(1./(dx*dx)+ 1./(dy*dy)))

end subroutine pas_de_tps
