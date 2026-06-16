#[cfg(feature = "serde")]
use serde::{Deserialize, Serialize};


#[link(name = "xsens_mti_ros2_driver__rosidl_typesupport_c")]
extern "C" {
    fn rosidl_typesupport_c__get_message_type_support_handle__xsens_mti_ros2_driver__msg__XsStatusWord() -> *const std::ffi::c_void;
}

#[link(name = "xsens_mti_ros2_driver__rosidl_generator_c")]
extern "C" {
    fn xsens_mti_ros2_driver__msg__XsStatusWord__init(msg: *mut XsStatusWord) -> bool;
    fn xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__init(seq: *mut rosidl_runtime_rs::Sequence<XsStatusWord>, size: usize) -> bool;
    fn xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__fini(seq: *mut rosidl_runtime_rs::Sequence<XsStatusWord>);
    fn xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__copy(in_seq: &rosidl_runtime_rs::Sequence<XsStatusWord>, out_seq: *mut rosidl_runtime_rs::Sequence<XsStatusWord>) -> bool;
}

// Corresponds to xsens_mti_ros2_driver__msg__XsStatusWord
#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]

/// Define the custom XsStatusWord message

#[repr(C)]
#[derive(Clone, Debug, PartialEq, PartialOrd)]
pub struct XsStatusWord {

    // This member is not documented.
    #[allow(missing_docs)]
    pub selftest: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub filter_valid: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub gnss_fix: bool,

    /// 0: not running, 2: aborted, 3:running
    pub no_rotation_update_status: u8,


    // This member is not documented.
    #[allow(missing_docs)]
    pub representative_motion: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clock_bias_estimation: bool,

    /// bool reserved1
    pub clipflag_acc_x: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_acc_y: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_acc_z: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_gyr_x: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_gyr_y: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_gyr_z: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_mag_x: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_mag_y: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub clipflag_mag_z: bool,

    /// uint8 reserved2
    pub clipping_indication: bool,

    /// bool reserved3
    pub syncin_marker: bool,


    // This member is not documented.
    #[allow(missing_docs)]
    pub syncout_marker: bool,

    /// 0: Without GNSS, 1: Coasting, 3: With GNSS
    pub filter_mode: u8,


    // This member is not documented.
    #[allow(missing_docs)]
    pub have_gnss_time_pulse: bool,

    /// 0: No RTK, 1: RTK Floating, 2: RTK Fix
    pub rtk_status: u8,

}



impl Default for XsStatusWord {
  fn default() -> Self {
    unsafe {
      let mut msg = std::mem::zeroed();
      if !xsens_mti_ros2_driver__msg__XsStatusWord__init(&mut msg as *mut _) {
        panic!("Call to xsens_mti_ros2_driver__msg__XsStatusWord__init() failed");
      }
      msg
    }
  }
}

impl rosidl_runtime_rs::SequenceAlloc for XsStatusWord {
  fn sequence_init(seq: &mut rosidl_runtime_rs::Sequence<Self>, size: usize) -> bool {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__init(seq as *mut _, size) }
  }
  fn sequence_fini(seq: &mut rosidl_runtime_rs::Sequence<Self>) {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__fini(seq as *mut _) }
  }
  fn sequence_copy(in_seq: &rosidl_runtime_rs::Sequence<Self>, out_seq: &mut rosidl_runtime_rs::Sequence<Self>) -> bool {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__XsStatusWord__Sequence__copy(in_seq, out_seq as *mut _) }
  }
}

impl rosidl_runtime_rs::Message for XsStatusWord {
  type RmwMsg = Self;
  fn into_rmw_message(msg_cow: std::borrow::Cow<'_, Self>) -> std::borrow::Cow<'_, Self::RmwMsg> { msg_cow }
  fn from_rmw_message(msg: Self::RmwMsg) -> Self { msg }
}

impl rosidl_runtime_rs::RmwMessage for XsStatusWord where Self: Sized {
  const TYPE_NAME: &'static str = "xsens_mti_ros2_driver/msg/XsStatusWord";
  fn get_type_support() -> *const std::ffi::c_void {
    // SAFETY: No preconditions for this function.
    unsafe { rosidl_typesupport_c__get_message_type_support_handle__xsens_mti_ros2_driver__msg__XsStatusWord() }
  }
}


#[link(name = "xsens_mti_ros2_driver__rosidl_typesupport_c")]
extern "C" {
    fn rosidl_typesupport_c__get_message_type_support_handle__xsens_mti_ros2_driver__msg__ShipMotion() -> *const std::ffi::c_void;
}

#[link(name = "xsens_mti_ros2_driver__rosidl_generator_c")]
extern "C" {
    fn xsens_mti_ros2_driver__msg__ShipMotion__init(msg: *mut ShipMotion) -> bool;
    fn xsens_mti_ros2_driver__msg__ShipMotion__Sequence__init(seq: *mut rosidl_runtime_rs::Sequence<ShipMotion>, size: usize) -> bool;
    fn xsens_mti_ros2_driver__msg__ShipMotion__Sequence__fini(seq: *mut rosidl_runtime_rs::Sequence<ShipMotion>);
    fn xsens_mti_ros2_driver__msg__ShipMotion__Sequence__copy(in_seq: &rosidl_runtime_rs::Sequence<ShipMotion>, out_seq: *mut rosidl_runtime_rs::Sequence<ShipMotion>) -> bool;
}

// Corresponds to xsens_mti_ros2_driver__msg__ShipMotion
#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]


// This struct is not documented.
#[allow(missing_docs)]

#[repr(C)]
#[derive(Clone, Debug, PartialEq, PartialOrd)]
pub struct ShipMotion {

    // This member is not documented.
    #[allow(missing_docs)]
    pub header: std_msgs::msg::rmw::Header,

    /// meters
    pub heave_position: f64,

    /// seconds
    pub heave_period: f64,

}



impl Default for ShipMotion {
  fn default() -> Self {
    unsafe {
      let mut msg = std::mem::zeroed();
      if !xsens_mti_ros2_driver__msg__ShipMotion__init(&mut msg as *mut _) {
        panic!("Call to xsens_mti_ros2_driver__msg__ShipMotion__init() failed");
      }
      msg
    }
  }
}

impl rosidl_runtime_rs::SequenceAlloc for ShipMotion {
  fn sequence_init(seq: &mut rosidl_runtime_rs::Sequence<Self>, size: usize) -> bool {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__ShipMotion__Sequence__init(seq as *mut _, size) }
  }
  fn sequence_fini(seq: &mut rosidl_runtime_rs::Sequence<Self>) {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__ShipMotion__Sequence__fini(seq as *mut _) }
  }
  fn sequence_copy(in_seq: &rosidl_runtime_rs::Sequence<Self>, out_seq: &mut rosidl_runtime_rs::Sequence<Self>) -> bool {
    // SAFETY: This is safe since the pointer is guaranteed to be valid/initialized.
    unsafe { xsens_mti_ros2_driver__msg__ShipMotion__Sequence__copy(in_seq, out_seq as *mut _) }
  }
}

impl rosidl_runtime_rs::Message for ShipMotion {
  type RmwMsg = Self;
  fn into_rmw_message(msg_cow: std::borrow::Cow<'_, Self>) -> std::borrow::Cow<'_, Self::RmwMsg> { msg_cow }
  fn from_rmw_message(msg: Self::RmwMsg) -> Self { msg }
}

impl rosidl_runtime_rs::RmwMessage for ShipMotion where Self: Sized {
  const TYPE_NAME: &'static str = "xsens_mti_ros2_driver/msg/ShipMotion";
  fn get_type_support() -> *const std::ffi::c_void {
    // SAFETY: No preconditions for this function.
    unsafe { rosidl_typesupport_c__get_message_type_support_handle__xsens_mti_ros2_driver__msg__ShipMotion() }
  }
}


