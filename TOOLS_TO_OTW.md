You can't clone from Github on an OverTheWire (OTW) game server, but you can use `scp` to upload files.

On OTW server:
```
$ mktemp -d
/tmp/tmp.AaSsDdFf1
```

Locally:
```
$ git clone https://github.com/osusec/ctf.git
[output snipped]

$ tar cvzf ctf.tar.gz ctf/
[output snipped]

$ scp -P [game port] ctf.tar.gz [username]@[game].lab.overthewire.org:/tmp/tmp.AaSsDdFf1
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames 
[username]@[game].labs.overthewire.org's password:                                                                                                                                                              
ctf.tar.gz                                                                       100%   19KB  48.2KB/s   00:00    
```

On OTW server:
```
$ cd /tmp/tmp.AaSsDdFf1

$ tar xvzf ctf.tar.gz
[output snipped]
```

You now can work with the CTF repo data on an OverTheWire game server, or any wargame system that blocks outbound connections!
