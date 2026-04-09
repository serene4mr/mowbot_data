# Mowbot Environment Variables

This document catalogs the environment variables used throughout the Mowbot stack to configure robot identity, paths, and ROS 2 network settings.

## Core Mowbot Variables

These variables are explicitly queried in the launch files and Python scripts across the `mowbot_sdk` and `mowbot_launch` packages. 

| Variable Name | Default Value | Description |
|---|---|---|
| `ROBOT_ID` | *(None, usually required)* | The unique identifier for the robot instance. It is heavily used for namespacing in Gazebo and ROS, and directly serves as the `serial_number` in VDA5050 communication. Example: `mowbot_001`. |
| `DATA_PATH` | `/mowbot_data` | The absolute path to the main configuration and data directory. Used to resolve the location of parameter files like `mission_bridge.params.yaml`. |
| `MANUFACTURER` | `MowbotTech` | The manufacturer name injected specifically into the `mission_bridge` for VDA5050 fleet management protocols. |
| `ROBOT_MODEL` | `mowbot_gazebo_modelv3`* | Specifies the physical/simulation robot model being used. *(Present in `.env.example`)* |
| `SENSOR_MODEL` | `mowbot_gazebo_sensor_kit`* | Specifies the sensor kit attached to the robot. *(Present in `.env.example`)* |
| `NTRIP_CLIENT_DEBUG` | `False` | Used internally by the `ntrip_client_ros` component to enable or disable debug logging. |

## Standard ROS 2 / Middleware Variables

These variables are standard to ROS 2 deployments and are managed via your environment to ensure proper networking and logging.

| Variable Name | Description |
|---|---|
| `ROS_DOMAIN_ID` | Isolates ROS 2 traffic to a specific logical network (useful when running multiple distinct robots on the same Wi-Fi). |
| `RMW_IMPLEMENTATION` | Selects the DDS vendor (e.g., `rmw_cyclonedds_cpp` or `rmw_fastrtps_cpp`). |
| `RCUTILS_LOGGING_SEVERITY_THRESHOLD`| Sets the global logging level (e.g., `DEBUG`, `INFO`, `WARN`). |
