!-------------------------------------------------------------------------------
! Name: deallocate_ecmwf_structures.F90
!
! Purpose:
! Deallocate the array parts of the types defined in ecmwf_structures.F90
!
! Description and Algorithm details:
! 1) Deallocate all arrays.
!
! Arguments:
! Name  Type   In/Out/Both Description
! ------------------------------------------------------------------------------
! ecmwf struct both Structure summarising contents of ECMWF files.
!
! History:
! 2012/01/13, MJ: produces draft code for ERA Interim grib 1 parameters required
! 2014/05/07, AP: new version of structures
! 2014/11/04, OS: added deallocation of skin temperature
! 2014/11/04, OS: added deallocation of snow_depth and sea_ice_cover
! 2015/12/17, OS: Added low_res flag.
!
! $Id$
!
! Bugs:
! None known.
!-------------------------------------------------------------------------------

subroutine deallocate_ecmwf_structures(ecmwf, low_res)

   use preproc_constants_m

   implicit none

   type(ecmwf_t), intent(inout) :: ecmwf
   logical,       intent(in)    :: low_res

   deallocate(ecmwf%lon)
   deallocate(ecmwf%lat)
   if (low_res) then
      deallocate(ecmwf%avec)
      deallocate(ecmwf%bvec)
      deallocate(ecmwf%u10)
      deallocate(ecmwf%v10)
   end if
   deallocate(ecmwf%skin_temp)
   deallocate(ecmwf%snow_depth)
   deallocate(ecmwf%sea_ice_cover)

end subroutine deallocate_ecmwf_structures
