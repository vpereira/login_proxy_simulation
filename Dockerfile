FROM opensuse/leap:15.3

# RUN zypper addrepo https://download.opensuse.org/repositories/home:/vpereirabr:/branches:/Apache/openSUSE_Leap_15.3/home:vpereirabr:branches:Apache.repo

RUN zypper addrepo https://download.opensuse.org/repositories/home:/vpereirabr:/branches:/SUSE:/SLE-15-SP2:/Update/standard/home:vpereirabr:branches:SUSE:SLE-15-SP2:Update.repo

RUN zypper addrepo https://download.opensuse.org/repositories/home:/vpereirabr:/branches:/OBS:/Server:/Unstable/15.3/home:vpereirabr:branches:OBS:Server:Unstable.repo

RUN zypper --gpg-auto-import-keys ref

RUN zypper -n in apache2-mod_auth_memcookie apache2-utils vim

RUN ln -s /usr/lib64/apache2/mod_auth_memcookie.so /usr/lib64/apache2-prefork/mod_auth_memcookie.so

COPY loadmodule.conf /etc/apache2
COPY listen.conf /etc/apache2
COPY mod_auth_memcookie.conf /etc/apache2
COPY httpd.conf /etc/apache2

RUN htpasswd -c -b /etc/apache2/htpasswd admin opensuse

ENTRYPOINT ["/usr/sbin/apachectl","-D","FOREGROUND"]
