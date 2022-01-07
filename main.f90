	program main
	implicit none 
 	integer ::nx ,ny ,nz
!
!       PARAMETRES ICCG
        integer ::ndim,mdim	
        real*8,allocatable :: coef(:,:) 

	real*8 ,allocatable :: rhs1(:),p_s(:),r_s(:),r2_s(:)
	real*8 ,allocatable :: q_s(:),s_s(:),x1(:)
	real*8 ,allocatable ::l_s(:,:)
        integer,allocatable :: jcoef(:)
	integer,dimension(1:5):: ldiag

	
	real*8 :: dx,dy,dt, tf
	real*8 :: zeta,time
	real*8 ,allocatable :: xx(:)
	real*8 ,allocatable :: yy(:)
	real*8 ,allocatable :: rhs_u(:,:),rhs_v(:,:),rhs(:,:)
	real*8 ,allocatable :: u_cent(:,:),v_cent(:,:),rot(:,:)
	real*8 ,allocatable :: div(:,:),pre(:,:)
	real*8, allocatable :: u(:,:),v(:,:),uetoile(:,:),vetoile(:,:)
	real*8 pi,sum,premoy,pamoy,Re,nu
	integer i,j,k,l,itmax,isto,istep,nstep,schema
	real*8 :: dkinetic, dnorme1u, dnorme2u, dnormeinfu
	real*8 :: dnorme1v, dnorme2v, dnormeinfv, epsi


!	external ICCG2	
	call parametre(tf,Re,schema,nx,ny,nz,epsi)	

	ndim = nx*ny
	mdim = 3

	allocate(coef(1:ndim,1:mdim))
	allocate(rhs1(1:ndim), p_s(1:ndim), r_s(1:ndim), r2_s(1:ndim))
	allocate(q_s(1:ndim),s_s(1:ndim),x1(1:ndim))
	allocate(l_s(1:ndim,1:5))
	allocate(jcoef(1:ndim))
	allocate(xx(1:nx))
	allocate(yy(1:ny))
	allocate(rhs_u(1:nx,1:ny),rhs_v(1:nx,1:ny),rhs(1:nx,1:ny),u_cent(1:nx,1:ny))
	allocate(v_cent(1:nx,1:ny),rot(1:nx,1:ny),div(1:nx,1:ny),pre(1:nx,1:ny))
	allocate(u(0:nx+1,0:ny+1),v(0:nx+1,0:ny+1),uetoile(0:nx+1,0:ny+1),vetoile(0:nx+1,0:ny+1))
	

    
	
	pi=4.*atan(1.)	
	time=0.	
	zeta=1.e-8
	itmax=300

	nu=1./Re
	dx=1./float(nx)
	dy=1./float(ny)	
	
	do i=1,nx
	 xx(i)=(i-0.5)*dx
	enddo
	
	do j=1,ny
	 yy(j)=(j-0.5)*dy
	enddo
	nstep = 0
	
   	! Initalisation 
   	call initialisation(u,v,nx,ny)

	! Initialisation des criteres de convergence
	dkinetic = 0.
	dnorme1u = 0.
	dnorme2u = 0. 
	dnormeinfu = 0.
	dnorme1v = 0.
	dnorme2v = 0. 
	dnormeinfv = 0.
	
	l = 0
 	! Boucle temporelle
	Do while (time < tf)
	l = l +1
     	call pas_de_tps(u,v,nu,dx,dy,nx,ny,dt)
	time = time + dt
	print*, time
	if (nstep == 0) then
		nstep = int(tf/dt)
	end if
	
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

	call test_conv(u_cent, v_cent, nx,ny, dnormeinfu, dnormeinfv, dnorme2u, &
	dnorme2v, dnorme1u, dnorme1v,dkinetic)


		
	enddo



	

	deallocate(coef)
	deallocate(rhs1, p_s, r_s, r2_s)
	deallocate(q_s,s_s,x1)
	deallocate(l_s)
	deallocate(jcoef)
	deallocate(xx)
	deallocate(yy)
	deallocate(rhs_u,rhs_v,rhs,u_cent,v_cent,rot,div,pre)
	deallocate(u,v,uetoile,vetoile)


	end 
