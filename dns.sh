dig +norec www.stanford.edu @b.root-servers.net  #root
dig +norec www.stanford.edu @b.edu-servers.net  #edu
dig +norec www.stanford.edu @atalante.stanford.edu #standford

#获得的answer
#www.stanford.edu.       1800    IN      CNAME   pantheon-systems.map.fastly.net.
//pantheon-systems.map.fastly.net
dig +norec pantheon-systems.map.fastly.net @b.root-servers.net #root

dig +norec pantheon-systems.map.fastly.net @c.gtld-servers.net #.net


dig +norec pantheon-systems.map.fastly.net @ns1.fastly.net #fastly
#获得的answer
# pantheon-systems.map.fastly.net. 30 IN  A       151.101.74.133



# eg2:
dig +norec www.scstanford.edu @b.root-servers.net  #root
dig +norec www.scstanford.edu @e.edu-servers.net  #edu

# ;; AUTHORITY SECTION:
# edu.                    900     IN      SOA     a.edu-servers.net. nstld.verisign-grs.com. 1649125172 1800 900 604800 86400