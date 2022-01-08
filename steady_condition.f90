function kinetic_energy(u_cent,v_cent,nx,ny)
	implicit none
	integer,intent(in):: nx,ny
	integer:: i,j
	real*8,dimension(nx,ny),intent(in)::u_cent,v_cent
	real*8::kinetic_energy
	kinetic_energy=0.
	do j=1,ny
		do i=1,nx
			kinetic_energy=kinetic_energy+0.5*(u_cent(i,j)**2+v_cent(i,j)**2)
		enddo
	enddo
	kinetic_energy = kinetic_energy/(float(nx*ny))
end function kinetic_energy




function norme1(A,nx,ny)   ! Norme 1 d'une matrice A de dimension nx*ny
	implicit none
	integer,intent(in):: nx,ny
	integer:: i,j
	real*8,dimension(nx,ny),intent(in)::A
	real*8::norme1
	norme1=0.
	do j=1,ny
		do i=1,nx
			norme1=norme1+abs(A(i,j))
		enddo
	enddo
	norme1 = norme1/(float(nx*ny))
end function norme1




function norme2(A,nx,ny)   ! Norme 2 d'une matrice A de dimension nx*ny
	implicit none
	integer,intent(in):: nx,ny
	integer:: i,j
	real*8,dimension(nx,ny),intent(in)::A
	real*8::norme2
	norme2=0.
	do j=1,ny
		do i=1,nx
			norme2=norme2+A(i,j)**2
		enddo
	enddo
	norme2=sqrt(norme2)
	norme2 = norme2/sqrt(float((nx*ny)))
end function norme2




function normeinf(A,nx,ny)   ! Norme infinie d'une matrice A de dimension nx*ny
	implicit none
	integer,intent(in):: nx,ny
	integer:: i,j
	real*8,dimension(nx,ny),intent(in)::A
	real*8::normeinf
	normeinf=maxval(abs(A))
end function normeinf 




