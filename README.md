# Linux Machine Learning Setup Script

This repository contains a script to easily set up essential machine learning tools on your Linux machine, with a focus on installing the `Nvidia Driver`, `Docker`, and `nvidia-docker2`.

The script supports two different environments:

1. Native environment
2. ESXi VM environment

**Important:** After completing the installation, please reboot your system.

## Usage
1. Clone this repository to your machine:
2. Make the setup script executable:
3. Run the `00.setup_common.sh` for install common parts.
4. Run the appropriate nvidia driver installation script for your environment:
- `10.setup_nvidia_onprem.sh`
- `10.setup_nvidia_esxi.sh` (this will install Nvidia Driver with `kernel-open` mode)