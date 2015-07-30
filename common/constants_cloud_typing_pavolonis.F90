!-------------------------------------------------------------------------------
! Name: constants_cloud_typing_pavolonis.F90
!
! Purpose:
! Defines parameters used by the Pavolonis cloud type identification code.
! Derived from constant.f90 by Andrew Heidinger, Andrew.Heidinger@noaa.gov
! within Clouds from AVHRR Extended (CLAVR-x) 1b PROCESSING SOFTWARE Version 5.3
!
! History:
! 2014/10/23, CS: Original version.
! 2014/12/01, OS: Added PROB_OPAQUE_ICE_TYPE.
! 2015/04/22, OS: Added new ANN cloud mask thresholds.
! 2015/07/02, OS: Added uncertainty constants variables.
! 2015/07/27, AP: Converted from a structure of variables to a module of
!    parameters (to be consistent with similar files elsewhere in the code).
!
! $Id$
!
! Bugs:
! None known.
!-------------------------------------------------------------------------------

module constants_cloud_typing_pavolonis

   use common_constants

   implicit none

   !--- cldmask OUTPUT
   integer(sint) :: CLOUDY = 1
   integer(sint) :: CLEAR = 0

   !--- constants used to determine cldmask uncertainty
   real(sreal)   :: CLEAR_UNC_MIN = 11.925 !24.364
   real(sreal)   :: CLEAR_UNC_MAX = 49.200 !60.066
   real(sreal)   :: CLOUDY_UNC_MIN = 1.862 !1.533
   real(sreal)   :: CLOUDY_UNC_MAX = 55.995 !43.620

   !--- ann_cloud_mask
   real(sreal)   :: COT_THRES_SEA = 0.05       !obsolete
   real(sreal)   :: COT_THRES_SEA_ICE = 0.5    !obsolete
   real(sreal)   :: COT_THRES_LAND = 0.3       !obsolete
   real(sreal)   :: COT_THRES_DAY_SEA_ICE = 0.4 
   real(sreal)   :: COT_THRES_DAY_LAND_ICE = 0.35
   real(sreal)   :: COT_THRES_DAY_SEA = 0.1
   real(sreal)   :: COT_THRES_DAY_LAND = 0.3
   real(sreal)   :: COT_THRES_NIGHT_SEA_ICE = 0.4
   real(sreal)   :: COT_THRES_NIGHT_LAND_ICE = 0.35
   real(sreal)   :: COT_THRES_NIGHT_SEA = 0.2
   real(sreal)   :: COT_THRES_NIGHT_LAND = 0.3

   !--- cldtype OUTPUT
   integer(sint) :: CLEAR_TYPE = 0
   integer(sint) :: PROB_CLEAR_TYPE = 1
   integer(sint) :: FOG_TYPE = 2
   integer(sint) :: WATER_TYPE = 3
   integer(sint) :: SUPERCOOLED_TYPE = 4
   integer(sint) :: MIXED_TYPE = 5
   integer(sint) :: OPAQUE_ICE_TYPE = 6
   integer(sint) :: CIRRUS_TYPE = 7
   integer(sint) :: OVERLAP_TYPE = 8
   integer(sint) :: PROB_OPAQUE_ICE_TYPE = 9 ! missing ch3.7 due to low S/N

   !--- used for sunglint_mask, nise_mask
   integer(sint) :: NO = 0
   integer(sint) :: YES = 1
   !--- used for ch3a_on_avhrr_flag (neither Ch3a nor Ch3b)
   integer(sint) :: INEXISTENT = -1

   !--- USGS: land use class (24 bit flags)
   !--- Aux_file_CM_SAF_AVHRR_GAC_ori_0.05deg.nc
   integer(sint) :: URBAN_AND_BUILTUP_LAND = 1
   integer(sint) :: DRYLAND_CROPLAND_AND_PASTURE = 2
   integer(sint) :: IRRIGATED_CROPLAND_AND_PASTURE = 3
   integer(sint) :: MIXED_DRYLAND_IRRIGATED_CROPLAND_AND_PASTURE = 4
   integer(sint) :: CROPLAND_GRASSLAND_MOSAIC = 5
   integer(sint) :: CROPLAND_WOODLAND_MOSAIC = 6
   integer(sint) :: GRASSLAND = 7
   integer(sint) :: SHRUBLAND = 8
   integer(sint) :: MIXED_SHRUBLAND_GRASSLAND = 9
   integer(sint) :: SAVANNA = 10
   integer(sint) :: DECIDUOUS_BROADLEAF_FOREST = 11
   integer(sint) :: DECIDUOUS_NEEDLELEAF_FOREST = 12
   integer(sint) :: EVERGREEN_BROADLEAF_FOREST = 13
   integer(sint) :: EVERGREEN_NEEDLELEAF_FOREST = 14
   integer(sint) :: MIXED_FOREST = 15
   integer(sint) :: WATER_BODIES = 16
   integer(sint) :: WATER_FLAG = 16       ! used in cloud_type subroutine
   integer(sint) :: HERBACEOUS_WETLAND = 17
   integer(sint) :: WOODED_WETLAND = 18
   integer(sint) :: BARREN_OR_SPARSELY_VEGETATED = 19
   integer(sint) :: DESERT_FLAG = 19      ! used in cloud_type subroutine
   integer(sint) :: HERBACEOUS_TUNDRA = 20
   integer(sint) :: WOODED_TUNDRA = 21
   integer(sint) :: MIXED_TUNDRA = 22
   integer(sint) :: BARE_GROUND_TUNDRA = 23
   integer(sint) :: SNOW_OR_ICE = 24

   !!--- LandCover_CCI map (22 bit flags)

   !--- SNOW/ICE Flag based on NISE aux. data
   integer(sint) :: NISE_FLAG = 30        ! used in cloud_type subroutine


   ! Used in original code cloud_type.f90, these apply to the sfc_type array 
!  integer(sint) :: WATER_SFC = 0
!  integer(sint) :: EVERGREEN_NEEDLE_SFC = 1
!  integer(sint) :: EVERGREEN_BROAD_SFC = 2
!  integer(sint) :: DECIDUOUS_NEEDLE_SFC = 3
!  integer(sint) :: DECIDUOUS_BROAD_SFC = 4
!  integer(sint) :: MIXED_FORESTS_SFC = 5
!  integer(sint) :: WOODLANDS_SFC = 6
!  integer(sint) :: WOODED_GRASS_SFC = 7
!  integer(sint) :: CLOSED_SHRUBS_SFC = 8
!  integer(sint) :: OPEN_SHRUBS_SFC = 9
!  integer(sint) :: GRASSES_SFC = 10
!  integer(sint) :: CROPLANDS_SFC = 11
!  integer(sint) :: BARE_SFC = 12
!  integer(sint) :: URBAN_SFC = 13

end module CONSTANTS_CLOUD_TYPING_PAVOLONIS