subroutine profiles(u,v,xx,yy,nx,ny,Re)
	implicit none
	integer,intent(in):: nx,ny
	integer:: imilieu,j,i,jmilieu
	real*8,dimension(0:nx+1,0:ny+1),intent(in)::u,v
	real*8,dimension(nx),intent(in)::xx
	real*8,dimension(ny),intent(in)::yy
	real*8::Re

	
	
	open(10,file='uprofile_Re='//CHAR(int(Re))//'_nx='//CHAR(nx)//'.dat')
	imilieu=ceiling(float(nx)/2.)
	write(10,*)'y','u'
	
	do j=1,ny
		write(10,*)yy(j),u(imilieu,j)
	enddo
	close(10)
	
	open(20,file='vprofile.dat')
	jmilieu=ceiling(float(ny)/2.)
	write(20,*)'x','v'
	
	do i=1,nx
		write(20,*)xx(i),v(i,jmilieu)
	enddo
	close(20)
	
end subroutine profiles
