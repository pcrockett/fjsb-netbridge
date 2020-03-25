fjsb-netbridge
==============

A plugin for [fj-sandbox][1] that configures sandbox network traffic to use a NATted bridge interface.

Since [firejail doesn't support L3 network interfaces][2], you can't directly route sandbox network traffic through some VPN interfaces (like WireGuard). One workaround is to fiddle around with `brctl` and `iptables` to set up NAT forwarding to the WireGuard interface. That tends to be a little complex; this plugin simplifies all that for you.

Usage
-----

```bash
git clone https://github.com/pcrockett/fjsb-netbridge
cd fjsb-netbridge

# Set up config file
cp config.template.sh config.sh
chmod u+x config.sh

# Edit config.sh however you want, then install the plugin:
install-fjsb-plugin .
```

[1]: https://github.com/pcrockett/fj-sandbox
[2]: https://github.com/netblue30/firejail/issues/1844#issuecomment-377069608
