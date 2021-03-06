!-------------------------------------------------------------------------------
! Name: utils_for_main.F90
!
! Purpose:
!
! History:
! 2015/02/24, GM: Pulled these out of preprocessing_for_orac.F90 to get them
!    module produced interfaces.
! 2015/09/14, GM: Move handle_parse_error() to trunk/common/parsing.F90.
! 2015/10/19, GM: Add use_modis_emis_in_rttov to parse_optional().
! 2015/11/26, GM: Add ecmwf_time_int_method, ecmwf_path_file, ecmwf_path_file2,
!    and ecmwf_path_file3 to parse_optional().
! 2016/02/02, CP: Add ecmwf_path_hr.
! 2016/02/02, GM: Add use_hr_ecmwf.
! 2016/02/02, GM: Add use_ecmwf_snow_and_ice.
! 2016/04/05, SP: Added ECMWF_NLEVELS option to choose between 60,91 and 137
!    level ECMWF input files.
! 2016/05/31, GT: Added use_l1_land_mask option to prevent USGS DEM from
!    overwriting the land/sea mask provided by L1 data (assuming the L1 data
!    provides one!)
! 2016/07/11, SP: Removed chunking routines to separate library in chunk_utils.
! 2017/02/10, SP: Allow reading LSM, LUM, DEM from external file (ExtWork)
! 2017/02/24, SP: Allow option to disable snow/ice correction
! 2017/03/29, SP: Add ability to calculate tropospheric cloud emissivity (ExtWork)
! 2017/04/08, SP: New flag to disable VIS processing, saves proc time (ExtWork)
! 2017/04/26, SP: Support for loading geoinfo (lat/lon/vza/vaa) from an
!                 external file. Supported by AHI, not yet by SEVIRI (ExtWork)
! 2017/08/09, SP: Add option to disable the cloud masking (ExtWork)
! 2017/09/14, GT: Added product_name optional argument
!
! $Id: utils_for_main.F90 4794 2017-08-11 09:01:12Z srproud $
!
! Bugs:
! None known.
!-------------------------------------------------------------------------------

module utils_for_main_m

   implicit none

contains

subroutine parse_required(lun, value, name)

   use parsing_m
   use preproc_constants_m

   implicit none

   integer,          intent(in)  :: lun
   character(len=*), intent(out) :: value
   character(len=*), intent(in)  :: name

   character(path_length) :: line

   if (parse_driver(lun, line) /= 0 .or. parse_string(line, value) /= 0) &
      call handle_parse_error(name)

end subroutine parse_required


subroutine parse_optional(label, value, n_channels, channel_ids, &
                          use_hr_ecmwf, ecmwf_time_int_method, &
                          use_ecmwf_snow_and_ice, use_modis_emis_in_rttov, &
                          ecmwf_path, ecmwf_path2, ecmwf_path3, ecmwf_path_hr, &
                          ecmwf_path_hr_2, ecmwf_nlevels, use_l1_land_mask, &
                          use_occci, occci_path, use_predef_lsm, ext_lsm_path, &
                          use_predef_geo, ext_geo_path, disable_snow_and_ice_corr,&
                          do_cloud_emis, do_ironly, do_cloud_type, product_name)

   use parsing_m
   use preproc_constants_m

   implicit none

   character(len=*), intent(in)    :: label
   character(len=*), intent(in)    :: value
   integer,          intent(inout) :: n_channels
   integer, pointer, intent(inout) :: channel_ids(:)
   logical,          intent(inout) :: use_hr_ecmwf
   integer,          intent(inout) :: ecmwf_time_int_method
   logical,          intent(inout) :: use_ecmwf_snow_and_ice
   logical,          intent(inout) :: use_modis_emis_in_rttov
   character(len=*), intent(inout) :: ecmwf_path
   character(len=*), intent(inout) :: ecmwf_path2
   character(len=*), intent(inout) :: ecmwf_path3
   character(len=*), intent(inout) :: ecmwf_path_hr
   character(len=*), intent(inout) :: ecmwf_path_hr_2
   integer,          intent(inout) :: ecmwf_nlevels
   logical,          intent(inout) :: use_l1_land_mask
   logical,          intent(inout) :: use_occci
   character(len=*), intent(inout) :: occci_path
   logical,          intent(inout) :: use_predef_lsm
   character(len=*), intent(inout) :: ext_lsm_path
   logical,          intent(inout) :: use_predef_geo
   character(len=*), intent(inout) :: ext_geo_path
   logical,          intent(inout) :: disable_snow_and_ice_corr
   logical,          intent(inout) :: do_cloud_emis
   logical,          intent(inout) :: do_ironly
   logical,          intent(inout) :: do_cloud_type
   character(len=*), intent(inout) :: product_name

   select case (label)
   case('N_CHANNELS')
      if (parse_string(value, n_channels) /= 0) &
         call handle_parse_error(label)
      allocate(channel_ids(n_channels))
   case('CHANNEL_IDS')
      if (n_channels == 0) then
         write(*,*) 'ERROR: must set option n_channels before option channels'
         stop error_stop_code
      end if
      if (parse_string(value, channel_ids) /= 0) &
         call handle_parse_error(label)
   case('USE_HR_ECMWF')
      if (parse_string(value, use_hr_ecmwf) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_TIME_INT_METHOD')
      if (parse_string(value, ecmwf_time_int_method) /= 0) &
         call handle_parse_error(label)
   case('USE_ECMWF_SNOW_AND_ICE')
      if (parse_string(value, use_ecmwf_snow_and_ice) /= 0) &
         call handle_parse_error(label)
   case('USE_MODIS_EMIS_IN_RTTOV')
      if (parse_string(value, use_modis_emis_in_rttov) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_PATH_2')
      if (parse_string(value, ecmwf_path) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_PATH2_2')
      if (parse_string(value, ecmwf_path2) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_PATH3_2')
      if (parse_string(value, ecmwf_path3) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_PATH_HR')
      if (parse_string(value, ecmwf_path_hr) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_PATH_HR_2')
      if (parse_string(value, ecmwf_path_hr_2) /= 0) &
         call handle_parse_error(label)
   case('ECMWF_NLEVELS')
      if (parse_string(value, ecmwf_nlevels) /= 0) &
         call handle_parse_error(label)
   case('USE_L1_LAND_MASK')
      if (parse_string(value, use_l1_land_mask) /= 0) &
         call handle_parse_error(label)
   case('USE_OCCCI')
      if (parse_string(value, use_occci) /= 0) &
           call handle_parse_error(label)
   case('OCCCI_PATH')
      if (parse_string(value, occci_path) /= 0) &
           call handle_parse_error(label)
   case('USE_PREDEF_LSM')
      if (parse_string(value, use_predef_lsm) /= 0) &
           call handle_parse_error(label)
   case('EXT_LSM_PATH')
      if (parse_string(value, ext_lsm_path) /= 0) &
           call handle_parse_error(label)
   case('USE_PREDEF_GEO')
      if (parse_string(value, use_predef_geo) /= 0) &
           call handle_parse_error(label)
   case('EXT_GEO_PATH')
      if (parse_string(value, ext_geo_path) /= 0) &
           call handle_parse_error(label)
   case('DISABLE_SNOW_ICE_CORR')
      if (parse_string(value, disable_snow_and_ice_corr) /= 0) &
           call handle_parse_error(label)
   case('DO_CLOUD_EMIS')
      if (parse_string(value, do_cloud_emis) /= 0) &
           call handle_parse_error(label)
   case('DO_IRONLY')
      if (parse_string(value, do_ironly) /= 0) &
           call handle_parse_error(label)
   case('DO_CLDTYPE')
      if (parse_string(value, do_cloud_type) /= 0) &
           call handle_parse_error(label)
   case('PRODUCT_NAME')
      if (parse_string(value, product_name) /=0) &
           call handle_parse_error(label)
   case default
      write(*,*) 'ERROR: Unknown option: ', trim(label)
      stop error_stop_code
   end select

end subroutine parse_optional


integer function parse_logical(string, value) result(status)

   use preproc_constants_m

   implicit none

   character(len=*), intent(in)  :: string
   logical,          intent(out) :: value

   status = 0

   if (trim(adjustl(string)) .eq. '1' .or.&
       trim(adjustl(string)) .eq. 't' .or. &
       trim(adjustl(string)) .eq. 'true' .or. &
       trim(adjustl(string)) .eq. 'T' .or. &
       trim(adjustl(string)) .eq. 'True') then
        value = .true.
   else if &
      (trim(adjustl(string)) .eq. '0' .or. &
       trim(adjustl(string)) .eq. 'f' .or. &
       trim(adjustl(string)) .eq. 'false' .or. &
       trim(adjustl(string)) .eq. 'F' .or. &
       trim(adjustl(string)) .eq. 'False') then
        value = .false.
   else
        status = -1
   end if

end function parse_logical

end module utils_for_main_m
