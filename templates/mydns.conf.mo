port=53
domain-needed
bogus-priv
resolv-file=/etc/resolv_dnsmasq.conf
strict-order
server=/{{MYDNS_DOMAIN}}/{{MYDNS_IPADDR}}
server=/{{MYDNS_IPADDR_REVERSE}}/{{MYDNS_IPADDR}}
local=/{{MYDNS_DOMAIN}}/
expand-hosts
domain={{MYDNS_DOMAIN}}
addn-hosts=/etc/hosts-dnsmasq
log-queries
log-facility=/var/log/dnsmasq.log
