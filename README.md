vagrant-dnsmasq
===============

For develop, set-up dnsmasq with virtual box.

Usage
-----

### Write your domain

**templates/hosts-dnsmasq.mo**

```
192.168.10.10 web
192.168.10.11 db
```

### Boot a guest machine

```bash
vagrant plugin install vagrant-vbguest
vagrant up
```

### Resolve name

```
host web <guest ip>
```

Custom Domain
-------------

Default is `localdomain.local`. If you change, edit `Vagrantfile`.

```
# guest's hostname and machine name
MYDNS_NAME = "mydns"
# guest ip
MYDNS_IPADDR = "192.168.10.110"
# custom domain dnsmasq adds
MYDNS_DOMAIN = "localdomain.local"
```

