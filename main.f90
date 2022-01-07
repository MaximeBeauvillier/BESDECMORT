	program main
	implicit none 
 	integer, parameter ::nx = 16 ,ny=16 ,nz=1
!
!       PARAMETRES ICCG
        integer, parameter ::ndim=nx*ny,mdim=3	
        real*8 ,dimension(1:ndim,1:mdim) :: coef 

	real*8 ,dimension(1:ndim) :: rhs1,p_s,r_s,r2_s
	real*8 ,dimension(1:ndim) :: q_s,s_s,x1
	real*8 ,dimension(1:ndim,1:5)::l_s
        integer, dimension(1:mdim):: jcoef
	integer, dimension(1:5):: ldiag

	
	real*8 :: dx,dy,dt, tf
	real*8 :: zeta,time
	real*8 ,dimension(1:nx) :: xx
	real*8 ,dimension(1:ny) :: yy
	real*8 ,dimension(1:nx,1:ny):: rhs_u,rhs_v,rhs,u_cent,v_cent,rot,div,pre
	real*8, dimension(0:nx+1,0:ny+1) :: u,v,uetoile,vetoile
	real*8 pi,sum,premoy,pamoy,Re,nu
	integer i,j,k,l,itmax,isto,istep,nstep,schema


    external ICCG2
	
	pi=4.*atan(1.)
	time=0.	
	zeta=1.e-8
	itmax=300

	call parametre(tf,Re,schema)

	nu=1./Re
	dx=1./float(nx)
	dy=1./float(ny)	
	
	do i=1,nx
	 xx(i)=(i-0.5)*dx
	enddo
	
	do j=1,ny
	 yy(j)=(j-0.5)*dy
	enddo
	
	
     ! Initalisation 
     call initialisation(u,v,nx,ny)

	l = 0
     ! Boucle temporelle
	Do while (time < tf)
	l = l +1
     	call pas_de_tps(u,v,nu,dx,dy,nx,ny,dt)
	time = time + dt
	
	call condition_limite(u,v,nx,ny) 

!        Calcul du second membre des équations de u et v	
	call calcul_rhs_u(u,dx,dy,nu,rhs_u,nx,ny)
	call calcul_rhs_v(v,dx,dy,nu,rhs_v,nx,ny)
	
	
	
!        Prédiction de vitesse
        call calcul_uetoile(nx,ny,u,v,dx,dy,uetoile,schema,rhs_u,dt)
        call calcul_vetoile(nx,ny,u,v,dx,dy,vetoile,schema,rhs_v,dt)
 
!        Calcul du second membre de l'équation de pression

	do j=1,ny
		do i=1,nx
			rhs(i,j)=1./dt*((uetoile(i,j)-uetoile(i-1,j))/dx &
				       +(vetoile(i,j)-vetoile(i,j-1))/dy)
	        enddo
	enddo  
	
       

!	GENERATION DE LA MATRICE des coef

	call matgen_cavite(coef,jcoef,nx,ny,ndim,mdim,dx,dy) 
	

	sum=0.0
	do j=1,ny
	   do i=1,nx
	      sum=sum+rhs(i,j)
	   enddo
	enddo

        sum=sum/float(nx*ny)
	k=1
	do j=1,ny
	   do i=1,nx
	      rhs(i,j)=rhs(i,j)-sum
	      rhs1(k) =-rhs(i,j)
	      x1(k)=0.
	      k=k+1
	    enddo
	enddo
	
!	RESOLUTION PRESSION

 	call ICCG2(coef,jcoef,l_s,Ldiag,rhs1,x1, &
      	       ndim,mdim,zeta,p_s,r_s,r2_s,q_s,s_s,itmax)
    
	k=1
	do j=1,ny 
	   do i=1,nx 
  	      pre(i,j)=x1(k)
	      k=k+1
	    enddo
	enddo
	do j=1,ny
	   write(10, '(8(2XE15.7))') (pre(i,j),i=1,nx)
	enddo

	
!	correction de la vitesse
	do j=1,ny 
	   do i=1,nx-1 
	   	u(i,j)=uetoile(i,j)-dt/dx*(pre(i+1,j)-pre(i,j))
	   enddo
	enddo 
		
	do j=1,ny-1
	   do i=1,nx 
	   	v(i,j)=vetoile(i,j)-dt/dy*(pre(i,j+1)-pre(i,j))
	   enddo
	enddo
	   
  
	   
	
	u_cent=0.5*(u(0:nx-1,1:ny)+u(1:nx,1:ny))
	v_cent=0.5*(v(1:nx,0:ny-1)+v(1:nx,1:ny))  
	call calcul_rot(rot,u,v,nx,ny,dx,dy)
	call calcul_div(div,u,v,nx,ny,dx,dy)
    	istep=l
	isto=5

    call write_result_ensight(xx,yy,u_cent,v_cent,rot,div,pre,nx,ny,nz,istep,isto,nstep)	
	
	enddo


	end 
