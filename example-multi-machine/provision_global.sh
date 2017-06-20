# Set UTC
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime


# Skip grub kernel menu
cp -n /etc/default/grub /etc/default/grub.original
sed -i '/^GRUB_TIMEOUT=/s/=.*/=0/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg


# Disable selinux
cp -n /etc/selinux/config /etc/selinux/config.original
sed -i '/^SELINUX=/s/=.*/=disabled/' /etc/selinux/config


# SSH settings
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sed -i '/^#UseDNS/s/^#//' /etc/ssh/sshd_config
sed -i '/^UseDNS/s/yes/no/' /etc/ssh/sshd_config
