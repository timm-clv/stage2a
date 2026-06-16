#[cfg(feature = "serde")]
use serde::{Deserialize, Serialize};



// Corresponds to xsens_mti_ros2_driver__msg__XsStatusWord
/// Define the custom XsStatusWord message

#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]
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
    <Self as rosidl_runtime_rs::Message>::from_rmw_message(super::msg::rmw::XsStatusWord::default())
  }
}

impl rosidl_runtime_rs::Message for XsStatusWord {
  type RmwMsg = super::msg::rmw::XsStatusWord;

  fn into_rmw_message(msg_cow: std::borrow::Cow<'_, Self>) -> std::borrow::Cow<'_, Self::RmwMsg> {
    match msg_cow {
      std::borrow::Cow::Owned(msg) => std::borrow::Cow::Owned(Self::RmwMsg {
        selftest: msg.selftest,
        filter_valid: msg.filter_valid,
        gnss_fix: msg.gnss_fix,
        no_rotation_update_status: msg.no_rotation_update_status,
        representative_motion: msg.representative_motion,
        clock_bias_estimation: msg.clock_bias_estimation,
        clipflag_acc_x: msg.clipflag_acc_x,
        clipflag_acc_y: msg.clipflag_acc_y,
        clipflag_acc_z: msg.clipflag_acc_z,
        clipflag_gyr_x: msg.clipflag_gyr_x,
        clipflag_gyr_y: msg.clipflag_gyr_y,
        clipflag_gyr_z: msg.clipflag_gyr_z,
        clipflag_mag_x: msg.clipflag_mag_x,
        clipflag_mag_y: msg.clipflag_mag_y,
        clipflag_mag_z: msg.clipflag_mag_z,
        clipping_indication: msg.clipping_indication,
        syncin_marker: msg.syncin_marker,
        syncout_marker: msg.syncout_marker,
        filter_mode: msg.filter_mode,
        have_gnss_time_pulse: msg.have_gnss_time_pulse,
        rtk_status: msg.rtk_status,
      }),
      std::borrow::Cow::Borrowed(msg) => std::borrow::Cow::Owned(Self::RmwMsg {
      selftest: msg.selftest,
      filter_valid: msg.filter_valid,
      gnss_fix: msg.gnss_fix,
      no_rotation_update_status: msg.no_rotation_update_status,
      representative_motion: msg.representative_motion,
      clock_bias_estimation: msg.clock_bias_estimation,
      clipflag_acc_x: msg.clipflag_acc_x,
      clipflag_acc_y: msg.clipflag_acc_y,
      clipflag_acc_z: msg.clipflag_acc_z,
      clipflag_gyr_x: msg.clipflag_gyr_x,
      clipflag_gyr_y: msg.clipflag_gyr_y,
      clipflag_gyr_z: msg.clipflag_gyr_z,
      clipflag_mag_x: msg.clipflag_mag_x,
      clipflag_mag_y: msg.clipflag_mag_y,
      clipflag_mag_z: msg.clipflag_mag_z,
      clipping_indication: msg.clipping_indication,
      syncin_marker: msg.syncin_marker,
      syncout_marker: msg.syncout_marker,
      filter_mode: msg.filter_mode,
      have_gnss_time_pulse: msg.have_gnss_time_pulse,
      rtk_status: msg.rtk_status,
      })
    }
  }

  fn from_rmw_message(msg: Self::RmwMsg) -> Self {
    Self {
      selftest: msg.selftest,
      filter_valid: msg.filter_valid,
      gnss_fix: msg.gnss_fix,
      no_rotation_update_status: msg.no_rotation_update_status,
      representative_motion: msg.representative_motion,
      clock_bias_estimation: msg.clock_bias_estimation,
      clipflag_acc_x: msg.clipflag_acc_x,
      clipflag_acc_y: msg.clipflag_acc_y,
      clipflag_acc_z: msg.clipflag_acc_z,
      clipflag_gyr_x: msg.clipflag_gyr_x,
      clipflag_gyr_y: msg.clipflag_gyr_y,
      clipflag_gyr_z: msg.clipflag_gyr_z,
      clipflag_mag_x: msg.clipflag_mag_x,
      clipflag_mag_y: msg.clipflag_mag_y,
      clipflag_mag_z: msg.clipflag_mag_z,
      clipping_indication: msg.clipping_indication,
      syncin_marker: msg.syncin_marker,
      syncout_marker: msg.syncout_marker,
      filter_mode: msg.filter_mode,
      have_gnss_time_pulse: msg.have_gnss_time_pulse,
      rtk_status: msg.rtk_status,
    }
  }
}


// Corresponds to xsens_mti_ros2_driver__msg__ShipMotion

// This struct is not documented.
#[allow(missing_docs)]

#[cfg_attr(feature = "serde", derive(Deserialize, Serialize))]
#[derive(Clone, Debug, PartialEq, PartialOrd)]
pub struct ShipMotion {

    // This member is not documented.
    #[allow(missing_docs)]
    pub header: std_msgs::msg::Header,

    /// meters
    pub heave_position: f64,

    /// seconds
    pub heave_period: f64,

}



impl Default for ShipMotion {
  fn default() -> Self {
    <Self as rosidl_runtime_rs::Message>::from_rmw_message(super::msg::rmw::ShipMotion::default())
  }
}

impl rosidl_runtime_rs::Message for ShipMotion {
  type RmwMsg = super::msg::rmw::ShipMotion;

  fn into_rmw_message(msg_cow: std::borrow::Cow<'_, Self>) -> std::borrow::Cow<'_, Self::RmwMsg> {
    match msg_cow {
      std::borrow::Cow::Owned(msg) => std::borrow::Cow::Owned(Self::RmwMsg {
        header: std_msgs::msg::Header::into_rmw_message(std::borrow::Cow::Owned(msg.header)).into_owned(),
        heave_position: msg.heave_position,
        heave_period: msg.heave_period,
      }),
      std::borrow::Cow::Borrowed(msg) => std::borrow::Cow::Owned(Self::RmwMsg {
        header: std_msgs::msg::Header::into_rmw_message(std::borrow::Cow::Borrowed(&msg.header)).into_owned(),
      heave_position: msg.heave_position,
      heave_period: msg.heave_period,
      })
    }
  }

  fn from_rmw_message(msg: Self::RmwMsg) -> Self {
    Self {
      header: std_msgs::msg::Header::from_rmw_message(msg.header),
      heave_position: msg.heave_position,
      heave_period: msg.heave_period,
    }
  }
}


