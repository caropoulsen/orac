!-------------------------------------------------------------------------------
! Name: ReadGeometry_nc.F90
!
! Purpose:
! Controls the reading of cloud flags values from ATSR-type files into the
! Data_CloudFlags array.
!
! Description and Algorithm details:
! if (MSI files are not yet open)
!    Find a logical unit number to be used for the cloud flag file
!    Open cloud flag file
!    If open error
!       Write error message to screen and log file
!    Else
!      Allocate MSI image segment array in Data_MSI struct.
!
! If (no error opening files)
!     Read header (not used further)
!     If read error
!        Write error message to screen and log file
!     Else
!        Read byte array of size defined by Ctrl structure
!        If read error
!           Write error message to log file
! Leave cloud flag file open for later reads
!
! Arguments:
! Name     Type   In/Out/Both Description
! ------------------------------------------------------------------------------
! Ctrl     struct Both        Control structure
! MSI_Data struct Both        Data structure: contains the cloud flag array
!                             to be populated with data from the file. This
!                             is overwritten as successive segments of data
!                             are read in.
!
! History:
! 2012/08/22, MJ: Uses original routine and implements reading of netcdf data.
! 2013/03/12, CP: Changed definition of relative azimuth angle
! 2013/05/21, GT: Undid previous change made by CP. The error was in th L1B
!    reading code in the preprocessing.
! 2014/08/02, GM: Cleaned up the code.
! 2014/08/15, AP: Switching to preprocessor NCDF routines.
! 2014/01/30, AP: Remove NSegs, SegSize arguments.
! 2015/07/03, OS: Added error status variable to nc_open call
! 2015/07/10, OS: undo previous commit
! 2015/09/07, AP: Allow verbose to be controlled from the driver file.
!
! $Id$
!
! Bugs:
! None known.
!-------------------------------------------------------------------------------

subroutine Read_Geometry_nc(Ctrl, MSI_Data)

   use Ctrl_m
   use ORAC_Constants_m
   use orac_ncdf_m

   implicit none

   ! Argument declarations

   type(Ctrl_t), intent(in)    :: Ctrl
   type(Data_t), intent(inout) :: MSI_Data

   integer :: ncid

   ! Open geometry file
   if (Ctrl%verbose) write(*,*) 'Geometry file: ', trim(Ctrl%FID%Geo)
   call nc_open(ncid, Ctrl%FID%Geo)

   allocate(MSI_Data%Geometry%Sol(Ctrl%Ind%Xmax, Ctrl%Ind%Ymax, Ctrl%Ind%NViews))
   allocate(MSI_Data%Geometry%Sat(Ctrl%Ind%Xmax, Ctrl%Ind%Ymax, Ctrl%Ind%NViews))
   allocate(MSI_Data%Geometry%Azi(Ctrl%Ind%Xmax, Ctrl%Ind%Ymax, Ctrl%Ind%NViews))

   call nc_read_array(ncid, "solzen", MSI_Data%Geometry%Sol, Ctrl%verbose)
   call nc_read_array(ncid, "satzen", MSI_Data%Geometry%Sat, Ctrl%verbose)
   call nc_read_array(ncid, "relazi", MSI_Data%Geometry%Azi, Ctrl%verbose)

   ! Close geometry file
   if (nf90_close(ncid) /= NF90_NOERR) then
      write(*,*) 'ERROR: read_geometry_nc(): Error closing file.'
      stop error_stop_code
   end if

end subroutine Read_Geometry_nc
