# Disable CPU frequency scaling
sudo apt-get update
sudo apt-get install -y cpufrequtils subversion git

# Create or edit cpufrequtils config file
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils

# Disable the ondemand service
sudo update-rc.d ondemand disable
sudo systemctl disable ondemand

# Restart cpufrequtils
sudo /etc/init.d/cpufrequtils restart

# Manually set performance mode for all cores
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Check CPU frequency settings
cpufreq-info

# Install low-latency kernel
sudo apt-get install -y linux-image-lowlatency linux-headers-lowlatency

